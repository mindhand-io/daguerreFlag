# A Self-Documenting Makefile: http://marmelab.com/blog/2016/02/29/auto-documented-makefile.html

# allow user to override go executable by running as GOEXE=xxx make ... on unix-like systems
GOEXE ?= go

.PHONY: all clean check-required-toolset help build test lint
.DEFAULT_GOAL := help

all: lint clean build build-linux

lint: check-required-toolset ## run code lint
	golangci-lint run

check-required-toolset:
	go get github.com/golangci/golangci-lint/cmd/golangci-lint@v1.27.0

build: ## build darwin(osx)
	go build -tags 'osusergo netgo' -o ./build/daguerreFlag.darwin

build-linux: ## build linux
	GOOS=linux GOARCH=amd64 go build -tags 'osusergo netgo' -o ./build/daguerreFlag.amd64

clean: ## clean up build artifacts
	rm -f ./build/daguerreFlag*

help: ## help
	@echo "daguerreFlag Makefile Tasks list:"
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {sub("\\\\n",sprintf("\n%22c"," "), $$2);printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)
