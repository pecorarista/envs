export LANG="C"
export LC_CTYPE="en_US.UTF-8"

if [ -f /etc/debian_version ]
then
    export CURL_CA_BUNDLE=/etc/ssl/certs/ca-certificates.crt
fi

if [ ! -f $HOME/.gitconfig ] && [ -f $HOME/envs/gitconfig ]
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
case $OSTYPE in
    linux*)
        if [ -x $HOME/.linuxbrew/bin/brew ]
        then
            eval $($HOME/.linuxbrew/bin/brew shellenv)
        elif [ -x /home/linuxbrew/.linuxbrew ]
        then
            eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
        fi
        ;;
    darwin*)
        if [ -x $HOME/homebrew/bin/brew ]
        then
            eval $($HOME/homebrew/bin/brew shellenv)
        fi
        ;;
esac

# Rust
if [ -f $HOME/.cargo/env ]
then
    source $HOME/.cargo/env
fi

# TeX
if [ -d /usr/local/texlive/2019 ]
then
    texlive_home=/usr/local/texlive/2019
    PATH=$texlive_home/bin/x86_64-linux:$PATH
    MANPATH=$texlive_home/texmf-dist/doc/man:$MANPATH
    INFOPATH=$texlive_home/texmf-dist/doc/info:$INFOPATH
fi

# Anaconda
function install-anaconda() {
    if [ ! -d $HOME/anaconda3 ]
    then
        case "$OSTYPE" in
            linux*)
                local url="https://repo.anaconda.com/archive/Anaconda3-2019.07-Linux-x86_64.sh";;
            darwin*)
                local url="https://repo.anaconda.com/archive/Anaconda3-2019.07-MacOSX-x86_64.sh";;
        esac
        mkdir -p $HOME/Downloads
        local filename="$HOME/Downloads/$(basename $url)"
        wget --no-clobber $url -O $filename
        bash $filename -b
    fi
}

unfunction install-anaconda

export ANACONDA_HOME=$HOME/anaconda3
PATH=$HOME/anaconda3/bin:$PATH

export PATH
export MANPATH
export INFOPATH

if grep -q "Microsoft" "/proc/version"
then
    export DISPLAY="localhost:0.0"
fi
