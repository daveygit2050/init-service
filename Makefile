.PHONY: bandit
bandit:
	poetry run bandit -c pyproject.toml --recursive .

.PHONY: black
black:
	poetry run black . --config=./pyproject.toml

.PHONY: build
build: test safety bandit
	poetry build

.PHONY: init
init:
	pip install --upgrade poetry
	poetry install
#    poetry run pre-commit install

.PHONY: publish
publish: build
	@poetry publish --username ${PYPI_USERNAME} --password ${PYPI_PASSWORD}

.PHONY: safety
safety:
	poetry run safety check --full-report

.PHONY: test
test: init black
	poetry run pytest tests/

.PHONY: update
update: init
	poetry update
