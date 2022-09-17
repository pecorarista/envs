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
[ -f "$HOME/.sdkman/bin/sdkman-init.sh" ] && source "$HOME/.sdkman/bin/sdkman-init.sh"

# JavaScript
[ -f "$HOME/.nvm/nvm.sh" ] && source "$HOME/.nvm/nvm.sh"

# Rust
[ -f $HOME/.cargo/env ] && source $HOME/.cargo/env

export C_INCLUDE_PATH="$HOME/local/include:$C_INCLUDE_PATH"
export CPLUS_INCLUDE_PATH=$C_INCLUDE_PATH
export LD_LIBRARY_PATH="$HOME/local/lib:$LD_LIBRRY_PATH"

export HOMEBREW_PREFIX="/home/linuxbrew/.linuxbrew";
export HOMEBREW_CELLAR="$HOMEBREW_PREFIX/Cellar";
export HOMEBREW_REPOSITORY="$HOMEBREW_PREFIX/Homebrew";
export PATH="$HOMEBREW_PREFIX/bin:$HOMEBREW_PREFIX/sbin:$PATH";
export MANPATH="$HOMEBREW_PREFIX/share/man:$NPM_PACKAGES/bin:$MANPATH";
export INFOPATH="$HOMEBREW_PREFIX/share/info:$INFOPATH";

eval "$(pyenv init --path)"
