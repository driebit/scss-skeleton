default: all

SCSS_FILES = $(shell find src -name '*.scss')

SHELL := /bin/bash
NPM_PATH := ./node_modules/.bin
ROOT_DIR:=$(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

export PATH := $(NPM_PATH):$(PATH)

all: $(SCSS_FILES)
	@node-sass src/style.scss dist/style.css

clean:
	@rm -Rf dist/*

deps:
	@npm install

distclean: clean
	@rm -Rf node_modules

help:
	@echo "Run: make <target> where <target> is one of the following:"
	@echo "  all                    Compile all Elm files"
	@echo "  clean                  Remove 'dist' folder"
	@echo "  deps                   Install build dependencies"
	@echo "  distclean              Remove build dependencies"
	@echo "  help                   Magic"
	@echo "  watch                  Run 'make all' on Elm file change"

watch:
	find src -name '*.scss' | entr make all
