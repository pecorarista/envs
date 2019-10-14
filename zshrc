function exists { which $1 &> /dev/null }

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

ANACONDA_HOME=$HOME/anaconda3
source $ANACONDA_HOME/etc/profile.d/conda.sh
conda activate

if ! exists powerline-daemon
then
    pip install --user powerline-status
fi

powerline-daemon -q
source "$HOME/.local/lib/python3.7/site-packages/powerline/bindings/zsh/powerline.zsh"

setopt histignorealldups sharehistory
setopt menu_complete

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history

autoload -Uz compinit
compinit

zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}'
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

bindkey '^[[1~' beginning-of-line
bindkey '^[[4~' end-of-line

function svg2pdf () {
    if ! $(which rsvg-convert &> /dev/null) && [ -f /etc/debian_version ]
    then
        echo 'The command `rsvg-convert` was not found. Install librsvg2-bin.'
    else
        rsvg-convert -f pdf -o ${1:r}.pdf $1
    fi
}

if [ -z "$SSH_AUTH_SOCK" ]
then
    eval $(ssh-agent) &> /dev/null
fi
if [ -z "$(ssh-add -l | awk -F' ' '{ print $3 }' | grep 'id_rsa')" ]
then
    ssh-add ~/.ssh/id_rsa &> /dev/null
fi

alias xs='ls -F --group-directories-first --color=never'
alias R='R --no-save'

if exists peco && exists fd
then
    function peco-history-selection() {
        BUFFER="$(history -n -r 1 | peco --query "$LBUFFER")"
        CURSOR=$#BUFFER
        zle reset-prompt
    }
    zle -N peco-history-selection
    bindkey '^R' peco-history-selection

    function peco-find() {
        BUFFER="$(fd --max-depth=6 --hidden --follow --exclude '.git' | peco --query "$LBUFFER")"
        CURSOR=$#BUFFER
        zle reset-prompt
    }
    zle -N peco-find
    bindkey '^T' peco-find
fi

if [ -z "$TMUX" ]
then
    tmux
fi
