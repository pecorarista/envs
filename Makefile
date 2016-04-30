.PHONY: stack

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
