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

if exists exa
then
    alias ls='exa'
    alias lx='exa --long --sort=old'
fi

if exists fdfind
then
    alias fd='fdfind'
fi

if exists rg
then
    alias grep='rg'
fi

case "$OSTYPE" in
    linux*)
        alias pbcopy='xclip';;
esac

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

eval "$(starship init zsh)"
