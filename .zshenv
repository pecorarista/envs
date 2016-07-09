export LC_COLLATE="C"

if [ -f /etc/debian_version ]
then
    export CURL_CA_BUNDLE=/etc/ssl/certs/ca-certificates.crt
fi

texlive=/usr/local/texlive/2016
manpath=(
    $manpath
    $texlive/texmf-dist/doc/man
)

export INFOPATH=$INFOPATH:$texlive/texmf-dist/doc/info

path=(
    ~/Anacondas/anaconda3/bin
    $texlive/bin/x86_64-linux
    $HOME/.local/bin
    $HOME/.local/share/umake/bin
    $path
)

# OCaml
source $HOME/.opam/opam-init/init.zsh &> /dev/null || true
