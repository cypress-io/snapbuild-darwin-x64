MKFILE_PATH := $(abspath $(lastword $(MAKEFILE_LIST)))
MKFILE_DIR := $(dir $(MKFILE_PATH))
ESBUILD_DIR := ${ESBUILD_DIR}
BIN_DIR := $(MKFILE_DIR)/bin

print:
	@echo ESBUILD_DIR = $(ESBUILD_DIR)
	@echo BIN_DIR = $(BIN_DIR)
	@echo if all checks out run:
	@echo "  ESBUILD_DIR=$(ESBUILD_DIR) make build"

build:
	make GOOS=darwin GOARCH=amd64 platform-unixlike

platform-unixlike:
	test -n "$(GOOS)" && test -n "$(GOARCH)" && test -n "$(ESBUILD_DIR)" && test -n "$(BIN_DIR)"
	mkdir -p $(BIN_DIR)
	cd "$(ESBUILD_DIR)" && GOOS="$(GOOS)" GOARCH="$(GOARCH)" go build "-ldflags=-s -w" -o "$(BIN_DIR)/snapshot" ./cmd/snapshot

clean:
	rm -rf ./bin/*
