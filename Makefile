SRC := firefox/mozilla-unified
DST := ${{HOME}/src/obj-x86_64-pc-linux-gnu/dist/

RED := '\033[0;31m'
NC := '\033[0m'

package: check
	@cd $${HOME}/${SRC}
	@bash mach package

build: check
	@test -d $${HOME}/${SRC} || echo "${SRC_NOT_EXIST_MESSAGE}"
	@cd $${HOME}/${SRC}
	@bash mach build

clean: check
	@test -d $${HOME}/${SRC} || echo "${SRC_NOT_EXIST_MESSAGE}"
	@cd $${HOME}/firefox/mozilla-unified
	@bash mach clobber

check:
	@test -d $${HOME}/${SRC} || echo "${RED}-----> please ssh to build node and run: make bootstrap-linux or make bootstrap-macos${NC}"; exit -1

bootstrap-linux:
	@echo "== Install build dependecies"
	@sudo apt install -y git tmux python3 python3-dev python3-pip mercurial default-jre-headless
	@mkdir -p $${HOME}/firefox
	@cd $${HOME}/firefox
	@curl https://hg.mozilla.org/mozilla-central/raw-file/default/python/mozboot/bin/bootstrap.py -O
	@python3 bootstrap.py --no-interactive
	@cd ${{HOME}/${SRC}
	@bash mach bootstrap

bootstrap-macos:
	@echo "== Install build dependecies"
