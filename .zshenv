export LC_COLLATE="C"

texlive=/usr/local/texlive/2016
export MANPATH=$MANPATH:$texlive/texmf-dist/doc/man
export INFOPATH=$INFOPATH:$texlive/texmf-dist/doc/info
export PATH=$texlive/bin/x86_64-linux:$HOME/.local/bin:$HOME/.local/share/umake/bin:$PATH

# OCaml
source $HOME/.opam/opam-init/init.zsh &> /dev/null || true
