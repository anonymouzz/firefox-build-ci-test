SRC := $${HOME}/projects/firefox/mozilla-unified
UNAME := $(shell uname)

RED := '\033[0;31m'
NC := '\033[0m'

ifeq ($(UNAME), Darwin)
  DIST_ROOT := $(SRC)/obj-x86_64-apple-darwin21.1.0
  DIST := $(SRC)/obj-x86_64-apple-darwin21.1.0/dist/firefox*.dmg
else ifeq ($(UNAME), Linux)
  DIST_ROOT := $(SRC)/obj-x86_64-apple-darwin21.1.0
  DIST := ${SRC}/obj-x86_64-pc-linux-gnu/dist/firefox*.bz2
else
  DIST_ROOT := $(SRC)/obj-x86_64-windows
  DIST := "Windows"
endif

package: check
	@cd ${SRC} && bash mach package
	@mkdir -p dist/
	@cp $(DIST) dist/

build: check
	@cd ${SRC} && bash mach build

clean: check
	@cd $(SRC) && bash mach clobber
	@cd $(SRC) && rm -fR $(DIST)

check:
	@test -d ${SRC} || (echo "${RED}-----> please ssh to build node and run: make bootstrap-linux or make bootstrap-macos${NC}" && exit -1)

boostrap:
	@mkdir -p $${HOME}/projects/firefox
	@mkdir -p $${HOME}/.mozbuild
	@cd $${HOME}/projects/firefox && curl https://hg.mozilla.org/mozilla-central/raw-file/default/python/mozboot/bin/bootstrap.py -O
	@cd $${HOME}/projects/firefox/ && python3 bootstrap.py --no-interactive
	@cd ${SRC} && bash mach bootstrap

prepare-linux:
	@echo "== Install build dependecies"
	@sudo apt install -y git tmux python3 python3-dev python3-pip mercurial default-jre-headless build-essential libpython3-dev m4 nodejs unzip uuid zip watchman

prepare-macos:
	@echo "== Install build dependecies"
	@brew install zsh tmux htop java mercurial
	@sudo xcode-select --switch /Applications/Xcode.app
	@sudo xcodebuild -license
