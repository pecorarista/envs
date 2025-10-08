function exists {
    which $1 &> /dev/null
}

export LANG=en_US.UTF-8
export LANGUAGE=en_US:en
export LC_ALL=en_US.UTF-8

if [ -d "$HOME/.local/bin" ]
then
    PATH="$HOME/.local/bin:$PATH"
fi

local texlive_home="/usr/local/texlive/2025"
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

# Ptyhon
[ -d "$HOME/.local/share/pypoetry/venv/bin" ] && PATH="$HOME/.local/share/pypoetry/venv/bin:$PATH"

export C_INCLUDE_PATH="$HOME/local/include:$C_INCLUDE_PATH"
export CPLUS_INCLUDE_PATH=$C_INCLUDE_PATH
export LD_LIBRARY_PATH="$HOME/local/lib:$LD_LIBRRY_PATH"

export HOMEBREW_PREFIX="/home/linuxbrew/.linuxbrew";
export HOMEBREW_CELLAR="$HOMEBREW_PREFIX/Cellar";
export HOMEBREW_REPOSITORY="$HOMEBREW_PREFIX/Homebrew";
export PATH="$HOME/.pyenv/bin:$HOMEBREW_PREFIX/bin:$HOMEBREW_PREFIX/sbin:$PATH";
export MANPATH="$HOMEBREW_PREFIX/share/man:$NPM_PACKAGES/bin:$MANPATH";
export INFOPATH="$HOMEBREW_PREFIX/share/info:$INFOPATH";

exists pyenv && eval "$(pyenv init - zsh)"
exists rbenv && eval "$(rbenv init - zsh)"
