.ONESHELL:
SHELL := /bin/bash

SRC = $(wildcard nbs/*.ipynb)

all: nbdev docs

nbdev: $(SRC)
	nbdev_build_lib
	touch nbdev

docs_serve: docs
	cd docs && bundle exec jekyll serve

docs: $(SRC)
	nbdev_build_docs
	touch docs

test:
	nbdev_test_nbs

release: pypi
	nbdev_conda_package --upload_user fastai
	nbdev_bump_version

conda_release:
	nbdev_conda_package --upload_user fastai
	nbdev_bump_version

pypi: dist
	twine upload --repository pypi dist/*

dist: clean
	python setup.py sdist bdist_wheel

clean:
	rm -rf dist

