.PHONY: vim anaconda anaconda2 anaconda3 nltk stack texlive

ANACONDA_HOME = $(HOME)/$@
ANACONDA_SCRIPT = $(shell echo "$@-4.0.0-Linux-x86_64.sh" | sed -e 's/^./\U&/')
ANACONDA_URL = http://repo.continuum.io/archive/$(ANACONDA_SCRIPT)
ANACONDA_VERSION = $(shell $(ANACONDA_HOME)/bin/python -c "from __future__ import print_function; import sys; version = sys.version.split('|')[1]; print(version if version == 'Anaconda custome (64-bit)' else '');" 2> /dev/null)

all: vim anaconda stack texlive
anaconda: anaconda2 anaconda3 nltk

anaconda2 anaconda3:
ifeq (,$(ANACONDA_VERSION))
	@if [ ! -d $(ANACONDA_HOME) ]; \
	then \
		wget $(ANACONDA_URL) -O anaconda/$(ANACONDA_SCRIPT); bash anaconda/$(ANACONDA_SCRIPT) -b; \
	else \
		:; \
	fi
else
	@echo "$(ANACONDA_VERSION) is already installed."
endif

nltk: anaconda3
	$(HOME)/anaconda3/bin/python -c "import nltk; nltk.download('all')"

stack:
	stack setup
	stack install cabal-install
	stack install ghc-mod
	git clone https://github.com/belliture/ghc-mod-stack-wrapper.git $(HOME)/.ghc-mod-stack-wrapper
	chmod +x $(HOME)/.ghc-mod-stack-wrapper/linux/ghc-mod
	chmod +x $(HOME)/.ghc-mod-stack-wrapper/linux/ghc-modi
	@if [ ! -d $(HOME)/bin ]; \
	then \
		mkdir $(HOME)/bin; \
	fi
	ln -sf $(HOME)/.ghc-mod-stack-wrapper/linux/ghc-mod $(HOME)/bin/ghc-mod
	ln -sf $(HOME)/.ghc-mod-stack-wrapper/linux/ghc-modi $(HOME)/bin/ghc-modi
