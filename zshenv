if [ -f /etc/debian_version ]
then
    export CURL_CA_BUNDLE=/etc/ssl/certs/ca-certificates.crt
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
fi
export LC_TIME="en_US.UTF-8"
export LC_COLLATE="C"

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