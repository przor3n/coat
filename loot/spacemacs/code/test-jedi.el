;;; test-jedi.el --- Tests for jedi.el

;; Copyright (C) 2012 Takafumi Arakaki

;; Author: Takafumi Arakaki <aka.tkf at gmail.com>

;; This file is NOT part of GNU Emacs.

;; test-jedi.el is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; test-jedi.el is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with test-jedi.el.
;; If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;;

;;; Code:

(eval-when-compile (require 'cl))
(require 'ert)

(require 'mocker)

(require 'jedi)

(defmacro with-python-temp-buffer (code &rest body)
  "Insert `code' and enable `python-mode'. cursor is beginning of buffer"
  (declare (indent 0) (debug t))
  `(with-temp-buffer
     (setq python-indent-guess-indent-offset nil)
     (insert ,code)
     (goto-char (point-min))
     (python-mode)
     (font-lock-fontify-buffer)
     ,@body))

(defun jedi-testing:sync (d)
  (epc:sync (jedi:get-epc) d))

(ert-deftest jedi:version ()
  "Check if `jedi:version' can be parsed by `version-to-list'."
  (version-to-list jedi:version))


;;; EPC

(ert-deftest jedi:complete-request ()
  (with-python-temp-buffer
    "
import json
json.l
"
    (goto-char (1- (point-max)))
    (jedi-testing:sync (jedi:complete-request))
    (should (equal (sort (jedi:ac-direct-matches) #'string-lessp)
                   '("load" "loads")))))

(ert-deftest jedi:get-in-function-call-request ()
  (with-python-temp-buffer
    "
def foobar(qux, quux):
    pass
foobar(obj,
"
    (goto-char (1- (point-max)))
    (destructuring-bind (&key params index call_name)
        (jedi-testing:sync (jedi:call-deferred 'get_in_function_call))
      (should (equal params '("qux" "quux")))
      (should (equal index 1))
      (should (equal call_name "foobar")))))

(ert-deftest jedi:goto-request ()
  (with-python-temp-buffer
    "
import json
json.load
"
    (goto-char (1- (point-max)))
    (let ((reply (jedi-testing:sync (jedi:call-deferred 'goto))))
      (destructuring-bind (&key line_nr module_path
                                column module_name description)
          (car reply)
        (should (integerp line_nr))
        (should (stringp module_path))))))

(ert-deftest jedi:get-definition-request ()
  (with-python-temp-buffer
    "
import json
json.load
"
    (goto-char (1- (point-max)))
    (let ((reply (jedi-testing:sync (jedi:call-deferred 'get_definition))))
      (destructuring-bind (&key doc desc_with_module line_nr column module_path
                                full_name name type description)
          (car reply)
        (should (stringp doc))
        (should (stringp desc_with_module))
        (should (integerp line_nr))
        (should (integerp column))
        (should (stringp module_path))))))

(ert-deftest jedi:show-version-info ()
  (kill-buffer (get-buffer-create "*jedi:version*"))
  (jedi-testing:sync (jedi:show-version-info))
  (should (get-buffer "*jedi:version*")))


;;; Server pool

(defmacro jedi-testing:with-mocked-server (start-epc-records
                                           epc--live-p-records
                                           buffers
                                           &rest body)
  (declare (indent 3))
  `(let ((jedi:server-pool--table (make-hash-table :test 'equal))
         (jedi:server-pool--gc-timer nil)
         ,@(mapcar
            (lambda (b) `(,b (generate-new-buffer "*jedi test*")))
            buffers))
     (mocker-let
         ((jedi:epc--start-epc (x y) ,start-epc-records)
          ;; FIXME: test suite is not yet adapted to resolving the command to
          ;; absolute path, so it is mocked to return the command untouched.
          (jedi:server-pool--resolve-command (command)
           ((:input-matcher (lambda (&rest _) t)
                            :output-generator (lambda (command) command))))
          (jedi:epc--live-p (x) ,epc--live-p-records)
          ;; Probably this mocking is too "strong".  What I need to
          ;; mock is only `buffer-list' in `jedi:-get-servers-in-use'.
          (buffer-list
           ()
           ((:input nil
                    :output-generator
                    (lambda ()
                      (loop for b in (list ,@buffers)
                            when (buffer-live-p b) collect b))
                    :min-occur 0)))
          (jedi:server-pool--gc-when-idle
           ()
           ((:record-cls 'mocker-stub-record))))
       (macrolet ((check-restart (&rest args)
                                 `(jedi-testing:check-start-server ,@args))
                  (set-server
                   (command &optional args)
                   `(progn
                      (set (make-local-variable 'jedi:server-command) ,command)
                      (set (make-local-variable 'jedi:server-args) ,args))))
         (unwind-protect
             (progn ,@body)
           (mapc #'kill-buffer (list ,@buffers)))))))

(defun jedi-testing:check-start-server (buffer command server)
  (with-current-buffer buffer
    (should-not jedi:epc)
    (should (eq (let ((jedi:server-command command)
                      (jedi:server-args nil))
                  (jedi:start-server))
                server))
    (should (eq jedi:epc server))))

(ert-deftest jedi:pool-single-server ()
  "Successive call of `jedi:start-server' with the same setup should
return the same server instance."
  (jedi-testing:with-mocked-server
      ;; Mock `epc:start-epc':
      ((:input '("python" ("jediepcserver.py")) :output 'dummy-server))
      ;; Mock `jedi:epc--live-p':
      ((:input '(nil) :output nil)         ; via `jedi:start-server'
       (:input '(dummy-server) :output t)) ; via `jedi:server-pool--start'
      ;; Buffers to use:
      (buf1 buf2)
    (check-restart buf1 '("python" "jediepcserver.py") 'dummy-server)
    (check-restart buf2 '("python" "jediepcserver.py") 'dummy-server)))

(ert-deftest jedi:pool-per-buffer-server ()
  "Successive call of `jedi:start-server' with different setups should
return the different server instances."
  (jedi-testing:with-mocked-server
      ;; Mock `epc:start-epc':
      ((:input '("python" ("jediepcserver.py")) :output 'dummy-server-1)
       (:input '("python3" ("jediepcserver.py")) :output 'dummy-server-2))
      ;; Mock `jedi:epc--live-p':
      ((:input '(nil) :output nil))     ; via `jedi:start-server'
      ;; Buffers to use:
      (buf1 buf2)
    (check-restart buf1 '("python" "jediepcserver.py") 'dummy-server-1)
    (check-restart buf2 '("python3" "jediepcserver.py") 'dummy-server-2)))

(ert-deftest jedi:pool-restart-per-buffer-server ()
  "When one of the server died, only the died server must be
rebooted; not still living ones."
  (jedi-testing:with-mocked-server
      ;; Mock `epc:start-epc':
      ((:input '("python" ("jediepcserver.py")) :output 'dummy-server-1)
       (:input '("python3" ("jediepcserver.py")) :output 'dummy-server-2)
       (:input '("python" ("jediepcserver.py")) :output 'dummy-server-3))
      ;; Mock `jedi:epc--live-p':
      ((:input '(nil) :output nil)            ; via `jedi:start-server'
       (:input '(dummy-server-1) :output t)
       (:input '(nil) :output nil)            ; via `jedi:start-server'
       (:input '(dummy-server-1) :output nil) ; server is stopped
       (:input '(nil) :output nil)            ; via `jedi:start-server'
       (:input '(dummy-server-2) :output t)
       (:input '(nil) :output nil)            ; via `jedi:start-server'
       (:input '(dummy-server-3) :output t))
      ;; Buffers to use:
      (buf1 buf2 buf3)
    (check-restart buf1 '("python" "jediepcserver.py") 'dummy-server-1)
    (check-restart buf2 '("python3" "jediepcserver.py") 'dummy-server-2)
    (check-restart buf3 '("python" "jediepcserver.py") 'dummy-server-1)
    (mapc (lambda (b) (with-current-buffer b (setq jedi:epc nil)))
          (list buf1 buf2 buf3))
    ;; Now, ``(jedi:epc--live-p dummy-server-1)`` will return nil:
    (check-restart buf1 '("python" "jediepcserver.py") 'dummy-server-3)
    (check-restart buf2 '("python3" "jediepcserver.py") 'dummy-server-2)
    (check-restart buf3 '("python" "jediepcserver.py") 'dummy-server-3)))

(ert-deftest jedi:pool-buffer-local-server-setting ()
  "Locally set `jedi:server-command' and `jedi:server-args' must be used."
  (jedi-testing:with-mocked-server
      ;; Mock `epc:start-epc':
      ((:input '("server" ("-abc")) :output 'dummy-1)
       (:input '("server" ("-xyz")) :output 'dummy-2))
      ;; Mock `jedi:epc--live-p':
      ((:input '(nil) :output nil)     ; via `jedi:start-server'
       (:input '(dummy-1) :output t))  ; via `jedi:server-pool--start'
      ;; Buffers to use:
      (buf1 buf2 buf3)
    ;; Set buffer local `jedi:server-command':
    (with-current-buffer buf1 (set-server '("server" "-abc")))
    (with-current-buffer buf2 (set-server '("server" "-xyz")))
    (with-current-buffer buf3 (set-server '("server" "-abc")))
    ;; Check that the buffer local `jedi:server-command' is used:
    (should (eq (with-current-buffer buf1 (jedi:start-server)) 'dummy-1))
    (should (eq (with-current-buffer buf2 (jedi:start-server)) 'dummy-2))
    (should (eq (with-current-buffer buf3 (jedi:start-server)) 'dummy-1))))

(ert-deftest jedi:pool-gc-when-no-jedi-buffers ()
  "GC should stop servers when there is no Jedi buffers."
  (jedi-testing:with-mocked-server
      ;; Mock `epc:start-epc':
      ((:input '("server" ("-abc")) :output 'dummy-1)
       (:input '("server" ("-xyz")) :output 'dummy-2))
      ;; Mock `jedi:epc--live-p':
      ((:input '(nil) :output nil))     ; via `jedi:start-server'
      ;; Buffers to use:
      (buf1 buf2)
    ;; Check that in this mocked environment there is no server yet:
    (should (= (length (jedi:-get-servers-in-use)) 0))
    ;; Start servers:
    (check-restart buf1 '("server" "-abc") 'dummy-1)
    (check-restart buf2 '("server" "-xyz") 'dummy-2)
    ;; GC should not stop servers in use:
    (jedi:server-pool--gc)
    (should (= (length (jedi:-get-servers-in-use)) 2))
    ;; GC should stop unused servers:
    (mapc #'kill-buffer (list buf1 buf2))
    (mocker-let ((epc:stop-epc (x) ((:input '(dummy-1))
                                    (:input '(dummy-2)))))
      (jedi:server-pool--gc))
    (should (= (length (jedi:-get-servers-in-use)) 0))))


;;; Misc

(ert-deftest jedi:show-setup-info-smoke-test ()
  (jedi:show-setup-info))


;;; Regression test

(ert-deftest regression-test-194 ()
  "Wrong column calculation when using TAB instead of space."
  (with-python-temp-buffer
    "
def func(a):
        pass

if True:
        x = 1
	func(x) # <- tab indentation
"
    (search-forward "def func(a):")
    (let ((def-line (line-number-at-pos)))
      (search-forward "func(x)")
      (goto-char (match-beginning 0))
      (let ((reply (jedi-testing:sync (jedi:call-deferred 'get_definition))))
        (destructuring-bind (&key doc desc_with_module line_nr column module_path
                                  full_name name type description)
            (car reply)
          (should (= line_nr def-line)))))))

;; Local Variables:
;; coding: utf-8
;; indent-tabs-mode: nil
;; End:

;;; test-jedi.el ends here
