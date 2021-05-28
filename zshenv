if [ -d "$HOME/.local/bin" ]
then
    PATH="$HOME/.local/bin:$PATH"
fi

local texlive_home=/usr/local/texlive/2020
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

# JVM Languages
export SDKMAN_DIR="$HOME/.sdkman"
local sdkman="$SDKMAN_DIR/bin/sdkman-init.sh"
if [ -f $sdkman ]
then
    source $sdkman
fi

# Rust
if [ -f $HOME/.cargo/env ]
then
    source $HOME/.cargo/env
fi

# Python
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"

export PATH
export MANPATH
export INFOPATH

# Make sure that VcXsrv is running and allowed to communicate with WSL2 by Windows Firewall
if [ -f "/proc/version" ] && grep -q -i "microsoft" "/proc/version"
then
    local local_ip="$(cat /etc/resolv.conf | grep nameserver | awk '{ print $2 }')"
    export DISPLAY="$local_ip:0.0"
fi
