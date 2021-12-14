SRC := firefox/mozilla-unified
DST := ${{HOME}/src/obj-x86_64-pc-linux-gnu/dist/

package:
	@cd $${HOME}/${SRC}
	@bash mach package

build:
	@cd $${HOME}/${SRC}
	@bash mach build

clean:
	@cd $${HOME}/firefox/mozilla-unified
	@bash mach clobber

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
