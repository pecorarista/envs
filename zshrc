bindkey -e

setopt histignorealldups sharehistory
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=$HOME/.zsh_history
PROMPT='%n@%m:%c$ '
ZLE_SPACE_SUFFIX_CHARS=$'|&'

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

if exists fdfind
then
    alias fd='fdfind'
fi

# GCP
if [ -f "$HOME/google-cloud-sdk/path.zsh.inc" ]
then
    . "$HOME/google-cloud-sdk/path.zsh.inc"
fi

if [ -f "$HOME/google-cloud-sdk/completion.zsh.inc" ]
then
    . "$HOME/google-cloud-sdk/completion.zsh.inc"
fi

alias R='R --no-save'
alias vi='vim'
case "$OSTYPE" in
    linux*)
        alias ls='ls -F --group-directories-first --color=auto'
        alias pbcopy='xclip';;
esac
alias lslt='ls -lt --color | less -R'

# Make sure that VcXsrv is running and allowed to communicate with WSL2 by Windows Firewall
if [ -f "/proc/version" ] && grep -q -i "microsoft" "/proc/version"
then
    local local_ip="$(cat /etc/resolv.conf | grep nameserver | awk '{ print $2 }')"
    export DISPLAY="$local_ip:0.0"
fi

if exists tmux && [ -z "$TMUX" ] && [ -z "$SSH_CONNECTION" ]
then
    tmux
fi
