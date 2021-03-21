.PHONY: clean clean-build clean-pyc clean-test coverage check_code dist dist-upload docs document docker format_code install lint requirements servedocs test test-all virtualenv

APP_NAME = app-name

TEST_FOLDERS = tests
CODE_FOLDERS = $(APP_NAME) folder $(TEST_FOLDERS)

CODE_PATHS = $(CODE_FOLDERS)

REMOTE_GIT_SERVER = git@dupa.pl
ORIGIN = origin
MASTER = master

REQUIREMENTS = requirements.txt
REQUIREMENTS_FREEZE = requirements_freeze.txt
REQUIREMENTS_DEV = requirements_dev.txt

print:
	@echo $(APP_NAME)
	@echo $(CODE_FOLDERS)
	@echo $(CODE_PATHS)
	@echo $(TEST_FOLDERS)

clean: clean-build clean-pyc clean-test ## remove all build, test, coverage and Python artifacts

clean-build: ## remove build artifacts
	rm -fr build/
	rm -fr dist/
	rm -fr .eggs/
	find . -name '*.egg-info' -exec rm -fr {} +
	find . -name '*.egg' -exec rm -f {} +

clean-pyc: ## remove Python file artifacts
	find . -name '*.pyc' -exec rm -f {} +
	find . -name '*.pyo' -exec rm -f {} +
	find . -name '*~' -exec rm -f {} +
	find . -name '__pycache__' -exec rm -fr {} +

clean-test: ## remove test and coverage artifacts
	rm -fr .tox/
	rm -f .coverage
	rm -fr htmlcov/
	rm -fr .pytest_cache

coverage: ## check code coverage quickly with the default Python
	coverage run --source $(CODE_PATHS) -m pytest
	coverage report -m
	coverage html
	$(BROWSER) htmlcov/index.html

check_code:
	pycodestyle $(CODE_PATHS)
	

dist: clean
	rm -rf dist/*
	python setup.py sdist
	python setup.py bdist_wheel

dist-upload:
	twine upload dist/*

docs: ## generate Sphinx HTML documentation, including API docs
	rm -f docs/$(APP_NAME).rst
	rm -f docs/modules.rst
	sphinx-apidoc -o docs/ $(CODE_PATHS)
	$(MAKE) -C docs clean
	$(MAKE) -C docs html
	$(BROWSER) docs/_build/html/index.html

document:
	pycco -spi -d docs/literate $(CODE_PATHS)

docker: clean
	docker build -t $(APP_NAME):latest .

fmt:
	black -Sq --config black.toml $(CODE_PATHS)
	
install: clean ## install the package to the active Python's site-packages
	python setup.py install

lint: ## check style with flake8
	flake8 $(CODE_PATHS)

requirements:
	.venv/bin/pip freeze --local > $(REQUIREMENTS_FREEZE)

remove-imports:
	autoflake -r --in-place \
		--remove-all-unused-imports \
		--exclude .venv,.git,.pytest_cache,__pycache__ \
		$(CODE_PATHS)

run:
	@echo "Put here code to run code"

sec:
	bandit -r $(CODE_PATHS)

servedocs: docs ## compile the docs watching for changes
	watchmedo shell-command -p '*.rst' -c '$(MAKE) -C docs html' -R -D .

test:
	python -m pytest \
		-v \
		--cov=simple \
		--cov-report=term \
		--cov-report=html:coverage-report \
		$(TEST_FOLDERS)

test-watcher:
	ptw $(CODE_PATHS) $(TEST_FOLDERS)

test-all: ## run tests on every Python version with tox
	tox

update:
	pip install -r $(REQUIREMENTS)

update-dev:
	pip install -r $(REQUIREMENTS_DEV)

virtualenv:
	virtualenv --prompt '|> $(APP_NAME) <| ' .venv
	.venv/bin/pip install -r $(REQUIREMENTS_DEV)
	.venv/bin/python setup.py develop
	@echo
	@echo "VirtualENV Setup Complete. Now run: source .venv/bin/activate"
	@echo

