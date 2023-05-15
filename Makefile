.PHONY: clean install build
LC_ALL=en_US.UTF-8
PYTHON := python

clean:
	@find . -name ".DS_Store" -print0 -exec rm -Rf {} \;
	@find . -name "Icon?" -print0 -exec rm -Rf {} \;
	@find . -type f -name '*.pyc' -delete
	@find . -type d -name "__pycache__" -delete
	@find . -type d -name "mlruns" | xargs rm -rf
	@-rm -rf *.egg-info
	@-rm -rf .coverage
	@-rm -rf junit.xml
	@-rm -rf coverage_html
	@-rm -rf .mypy_cache
	@-rm -rf .pytest_cache
	@-rm -rf htmlcov
	@-rm -rf mlruns
	@-rm -rf .eggs
	@-rm -rf .tox
	@-rm -rf __pycache__
	@-rm -rf cover
	@-rm -rf build
	@-rm -rf dist
	@-rm -rf *.log
	@echo "All clean!"

format:
	find telemetria_melchior -type f -name "*.py" | xargs $(PYTHON) -misort -l 100 --profile=black
	$(PYTHON) -m black telemetria_melchior --line-length 100
	$(PYTHON) -m black examples --line-length 100
	$(PYTHON) -m black tests --line-length 100

install:
	PIP_CONFIG_FILE=pip.conf $(PYTHON) -m pip install -r requirements.txt
	PIP_CONFIG_FILE=pip.conf $(PYTHON) -m pip install -r requirements_dev.txt

conda:
	conda install --file requirements.txt -y
	conda install --file requirements_dev.txt -y

pytest:
	@coverage run --source=telemetria_melchior -m pytest .
	@coverage report -m
	@coverage html -d coverage_html

lint:
	@find telemetria_melchior -type f -name "*.py" | xargs pylint --output-format=colorized
	@flake8 telemetria_melchior --max-line-length=100
	@mypy telemetria_melchior

viaops_tests:
	@coverage run --source=telemetria_melchior -m pytest .
	@find telemetria_melchior -type f -name "*.py" | xargs pylint
	@flake8 telemetria_melchior --max-line-length=100
	@mypy telemetria_melchior

test: pytest lint

dry-patch:
	bump2version --dry-run  patch --verbose

dry-minor:
	bump2version --dry-run  minor --verbose

dry-major:
	bump2version --dry-run  major --verbose

patch:
	bump2version  patch --verbose

minor:
	bump2version  minor --verbose

major:
	bump2version  major --verbose

build:
	$(PYTHON) -m build
