.PHONY: anaconda anaconda2 anaconda3 nltk stack texlive

ANACONDA_HOME = $(HOME)/$@
ANACONDA_SCRIPT = $(shell echo "$@-2.5.0-Linux-x86_64.sh" | sed -e 's/^./\U&/')
ANACONDA_URL = http://repo.continuum.io/archive/$(ANACONDA_SCRIPT)
ANACONDA_VERSION = $(shell $(ANACONDA_HOME)/bin/python -c "from __future__ import print_function; import sys; version = sys.version.split('|')[1]; print(version if version == 'Anaconda 2.5.0 (64-bit)' else '');" 2> /dev/null)

all: anaconda stack texlive
anaconda: anaconda2 anaconda3 nltk

anaconda2 anaconda3:
ifeq (,$(ANACONDA_VERSION))
	cd anaconda; (md5sum --check $@.md5) || (rm -f $(ANACONDA_SCRIPT); wget $(ANACONDA_URL))
	@if [ ! -d $(ANACONDA_HOME) ]; \
	then \
		bash anaconda/$(ANACONDA_SCRIPT) -b \
	else \
		:; \
	fi
else
	@echo "$(ANACONDA_VERSION) is already installed."
endif
	$(ANACONDA_HOME)/bin/conda install --file=anaconda/$@-requirements.txt -y

nltk: anaconda3
	$(HOME)/anaconda3/bin/python -c "import nltk; nltk.download('all')"

stack:
	stack setup
	stack install cabal-install
	stack install ghc-mod
	git clone https://github.com/belliture/ghc-mod-stack-wrapper.git $(HOME)/.ghc-mod-stack-wrapper
	chmod +x $(HOME)/.ghc-mod-stack-wrapper/linux/ghc-mod
	chmod +x $(HOME)/.ghc-mod-stack-wrapper/linux/ghc-modi
	ln -sf $(HOME)/.ghc-mod-stack-wrapper/linux/ghc-mod $(HOME)/bin/ghc-mod
	ln -sf $(HOME)/.ghc-mod-stack-wrapper/linux/ghc-modi $(HOME)/bin/ghc-modi

texlive:
	tlmgr init-usertree
	tlmgr update --self
