bindkey -e

setopt histignorealldups sharehistory
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=$HOME/.zsh_history
PROMPT='%n@%m:%c$ '

function exists {
    which $1 &> /dev/null
}

if exists powerline-daemon
then
    powerline-daemon -q
    plconf="$HOME/.local/lib/python3.8/site-packages/powerline/bindings/zsh/powerline.zsh"
    if [ -f $plconf ]
    then
        source $plconf
    fi
fi

case "$OSTYPE" in
    linux*)
        alias ls='ls -F --group-directories-first --color=auto';;
esac

if exists peco
then
    function peco-history() {
        BUFFER="$(history -n -r 1 | peco --prompt='history> ' --query="$LBUFFER")"
        CURSOR=$#BUFFER
        zle reset-prompt
    }
    zle -N peco-history
    bindkey '^R' peco-history
fi

if exists tmux && [ -z "$TMUX" ] && [ -z "$SSH_CONNECTION" ]
then
    tmux
fi
