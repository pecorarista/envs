if [ -d "$HOME/.local/bin" ]
then
    PATH="$HOME/.local/bin:$PATH"
fi

local texlive_home=/usr/local/texlive/2021
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
PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"

# JavaScript
export NVM_DIR="$HOME/.nvm"
if [ -f "$NVM_DIR/nvm.sh" ]
then
    source "$NVM_DIR/nvm.sh"
fi

export C_INCLUDE_PATH="$HOME/local/include:$C_INCLUDE_PATH"
export CPLUS_INCLUDE_PATH=$C_INCLUDE_PATH
export LD_LIBRARY_PATH="$HOME/local/lib:$LD_LIBRRY_PATH"

export PATH="$HOME/local/bin:$PATH"
export MANPATH
export INFOPATH
