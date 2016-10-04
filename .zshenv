export LC_COLLATE="C"

if [ -f /etc/debian_version ]
then
    export CURL_CA_BUNDLE=/etc/ssl/certs/ca-certificates.crt
fi

texlive=/usr/local/texlive/2016
export MANPATH=$MANPATH:$texlive/texmf-dist/doc/man
export INFOPATH=$INFOPATH:$texlive/texmf-dist/doc/info

path=(
    $texlive/bin/x86_64-linux
    $HOME/Anacondas/anaconda3/bin
    $HOME/bin
    $HOME/.local/bin
    $HOME/.local/share/umake/bin
    $path
)

# OCaml
source $HOME/.opam/opam-init/init.zsh &> /dev/null || true
