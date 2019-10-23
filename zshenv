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
local texlive_home=/usr/local/texlive/2019
if [ -d $texlive_home ]
then
    case $OSTYPE in
    linux*)
        PATH=$texlive_home/bin/x86_64-linux:$PATH
        ;;
    darwin*)
        PATH=$texlive_home/bin/x86_64-darwin:$PATH
        ;;
    esac
    MANPATH=$texlive_home/texmf-dist/doc/man:$MANPATH
    INFOPATH=$texlive_home/texmf-dist/doc/info:$INFOPATH
fi

export PATH
export MANPATH
export INFOPATH

if [ -f "/proc/version" ] && grep -q "Microsoft" "/proc/version"
then
    export DISPLAY="localhost:0.0"
fi
