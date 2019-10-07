;;; this is for helm left/right arrows
                                        ;(define-key helm-map (kbd "<left>") 'helm-previous-source)
                                        ;(define-key helm-map (kbd "<right>") 'helm-next-source)
(customize-set-variable 'helm-ff-lynx-style-map t)
(customize-set-variable 'helm-imenu-lynx-style-map t)
(customize-set-variable 'helm-semantic-lynx-style-map t)
(customize-set-variable 'helm-occur-use-ioccur-style-keys t)

;;; by default set the frame title 
(setq frame-title-format
      '(buffer-file-name "%f"
                         (dired-directory dired-directory "%b")))

;;; set pytest as test runner for python
(setq-default dotspacemacs-configuration-layers
              '((python :variables python-test-runner 'pytest)))

;;; formating on save
(setq-default dotspacemacs-configuration-layers
              '((python :variables python-enable-yapf-format-on-save t)))


(setq org-todo-keywords
      '(
        (sequence "IDEA(i)" "TODO(t)" "STARTED(s)" "NEXT(n)" "WAITING(w)" "|" "DONE(d)")
        (sequence "|" "CANCELED(c)" "DELEGATED(l)" "SOMEDAY(f)")
        ))

(setq org-todo-keyword-faces
      '(("IDEA" . (:foreground "GoldenRod" :weight bold))
        ("NEXT" . (:foreground "IndianRed1" :weight bold))   
        ("STARTED" . (:foreground "OrangeRed" :weight bold))
        ("WAITING" . (:foreground "coral" :weight bold)) 
        ("CANCELED" . (:foreground "LimeGreen" :weight bold))
        ("DELEGATED" . (:foreground "LimeGreen" :weight bold))
        ("SOMEDAY" . (:foreground "LimeGreen" :weight bold))
        ))

;;; Save and restore desktop state, see: desktop.el
;(setq desktop-path '("~/.emacs.d/"))
;(setq desktop-dirname "~/.emacs.d/")
;(setq desktop-base-file-name ".emacs.desktop")
;(desktop-save-mode 1)

;; sr speedbar
(require 'sr-speedbar)
