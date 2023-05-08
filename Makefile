## -*- mode: makefile-gmake -*-

SHELL = /bin/sh
EMACS ?= emacs
RM = @rm -rf
EMACS_BATCH_OPTS = --batch -Q -nw
EMACS_BATCH = $(EMACS) $(EMACS_BATCH_OPTS)

.PHONY: test clean spellcheck compile install


all: init.el

# Generate lisp and compile it
init.el: init.org clean-init
	@$(EMACS_BATCH) \
		--eval "(let ((debug-on-error t) (user-emacs-directory default-directory)) (org-babel-load-file \"init.org\"))"
	@chmod ugo-w $@


clean:
	$(RM) *~
	$(RM) \#*\# init.el early-init.el
	$(RM) *.elc
	$(RM) lisp/*.elc
	$(RM) tmp/
	$(RM) var/
	$(RM) straight/
	$(RM) eln-cache/
	$(RM) parinfer-rust/
	$(RM) auto-save-list
	$(RM) elpa packages straight

clean-init:
	@echo Deleting old init.el
	$(RM) init.el

startup: init.el
	./test-startup.sh
