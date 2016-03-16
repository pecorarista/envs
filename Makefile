.PHONY: anaconda2 anaconda3 clean

ANACONDA_HOME = $(HOME)/$@
ANACONDA_SCRIPT = $(shell echo "$@-2.5.0-Linux-x86_64.sh" | sed -e 's/^./\U&/')
ANACONDA_URL = http://repo.continuum.io/archive/$(ANACONDA_SCRIPT)
ANACONDA_VERSION = $(shell $(ANACONDA_HOME)/bin/python -c "from __future__ import print_function; import sys; version = sys.version.split('|')[1]; print(version if version == 'Anaconda 2.5.0 (64-bit)' else '');" 2> /dev/null)

anaconda2 anaconda3:
ifeq (,$(ANACONDA_VERSION))
	(md5sum --check anaconda/$@.md) || (rm -f $(ANACONDA_SCRIPT); wget $(ANACONDA_URL))
	@if [ ! -d $(ANACONDA_HOME) ]; \
	then \
		bash $(ANACONDA_SCRIPT) -b \
	else \
		:; \
	fi
else
	@echo "$(ANACONDA_VERSION) is already installed."
endif
	$(ANACONDA_HOME)/bin/conda install --file=anaconda/$@-requirements.txt -y
