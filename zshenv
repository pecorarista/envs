if [ -f /etc/debian_version ]
then
    export CURL_CA_BUNDLE=/etc/ssl/certs/ca-certificates.crt
fi

if [ ! -f $HOME/.gitconfig ]
then
    ln -s $HOME/envs/gitconfig $HOME/.gitconfig
fi

for d in "bin" "usr/bin" ".local/bin"
do
    if [ -d $HOME/$d ]
    then
        PATH=$HOME/$d:$PATH
    fi
done

# Linuxbrew
if [ -x $HOME/.linuxbrew/bin/brew ]
then
    eval $($HOME/.linuxbrew/bin/brew shellenv)
elif [ -x /home/linuxbrew/.linuxbrew ]
then
    eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
fi
export LC_ALL="C.UTF-8"

# Rust
if [ -f $HOME/.cargo/env ]
then
    source $HOME/.cargo/env
fi

# TeX
if [ -d /usr/local/texlive/2018 ]
then
    texlive_home=/usr/local/texlive/2018
    PATH=$texlive_home/bin/x86_64-linux:$PATH
    MANPATH=$texlive_home/texmf-dist/doc/man:$MANPATH
    INFOPATH=$texlive_home/texmf-dist/doc/info:$INFOPATH
fi

if [ -d $HOME/usr/lib ]
then
    LD_LIBRARY_PATH=$HOME/usr/lib:$LD_LIBRARY_PATH
fi

export LD_LIBRARY_PATH
export PATH
export MANPATH
export INFOPATH
