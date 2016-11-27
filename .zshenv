export LC_TIME="en_US.UTF-8"
export LC_COLLATE="C"

if [ -f /etc/debian_version ]
then
    export CURL_CA_BUNDLE=/etc/ssl/certs/ca-certificates.crt
fi

texlive_home=/usr/local/texlive/2016
export MANPATH=$MANPATH:$texlive/texmf-dist/doc/man
export INFOPATH=$INFOPATH:$texlive/texmf-dist/doc/info

if which ruby > /dev/null
then
    export GEM_HOME="$(ruby -e 'print Gem.user_dir')"
fi

ANACONDA_HOME=$HOME/Anacondas/anaconda3

path=(
    $texlive_home/bin/x86_64-linux
    $ANACONDA_HOME/bin
    $GEM_HOME/bin
    $HOME/bin
    $HOME/.local/bin
    $HOME/.local/share/umake/bin
    $path
)

# OCaml
source $HOME/.opam/opam-init/init.zsh &> /dev/null || true
