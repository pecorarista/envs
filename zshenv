if [ -f /etc/debian_version ]
then
    export CURL_CA_BUNDLE=/etc/ssl/certs/ca-certificates.crt
fi

if [ ! -L $HOME/.condarc ]
then
    ln -s $HOME/envs/.condarc $HOME/.condarc
fi

# Linuxbrew
eval $($HOME/.linuxbrew/bin/brew shellenv)
export LC_TIME="en_US.UTF-8"
export LC_COLLATE="C"

# OCaml
source $HOME/.opam/opam-init/init.zsh 2> /dev/null || true

# Python
if [ -d $HOME/anaconda3 ]
then
    ANACONDA_HOME=$HOME/anaconda3
    source $HOME/anaconda3/etc/profile.d/conda.sh
    conda activate
    PATH=$HOME/.local/bin:$PATH
fi

# Ruby
if which ruby &> /dev/null
then
    export GEM_HOME="$(ruby -e 'print Gem.user_dir')"
    PATH=$GEM_HOME/bin:$PATH
fi

# Rust
if [ ! -f $HOME/.cargo/env ]
then
    curl https://sh.rustup.rs -fsSf | sh
fi
source $HOME/.cargo/env

# TeX
if [ -d /usr/local/texlive/2018 ]
then
    texlive_home=/usr/local/texlive/2018
    PATH=$texlive_home/bin/x86_64-linux:$PATH
    MANPATH=$texlive_home/texmf-dist/doc/man:$MANPATH
    INFOPATH=$texlive_home/texmf-dist/doc/info:$INFOPATH
fi

if [ -d $HOME/usr/bin ]
then
    PATH=$HOME/usr/bin:$PATH
fi
if [ -d $HOME/usr/lib ]
then
    LD_LIBRARY_PATH=$HOME/usr/lib:$LD_LIBRARY_PATH
fi

export LD_LIBRARY_PATH
export PATH
export MANPATH
export INFOPATH
