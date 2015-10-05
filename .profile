# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# OPAM configuration
. $HOME/.opam/opam-init/init.sh > /dev/null 2> /dev/null || true

TEXLIVE=/usr/local/texlive/2015
export NLTK_DATA=$HOME/NLP/nltk_data
export LC_COLLATE=ja_JP.UTF-8
export INFOPATH=$TEXLIVE/texmf-dist/doc/info
export MANPATH=$TEXLIVE/texmf-dist/doc/man
export EDITOR=vim
export LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH
export PATH=$TEXLIVE/bin/x86_64-linux:$HOME/.cabal/bin:$HOME/Development/ghc-7.8.4/bin:$HOME/.rbenv/shims:/opt/anaconda/bin:$HOME/.local/bin:$PATH
export FCITX_NO_PREEDIT_APPS=konsole
