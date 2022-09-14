bindkey -e

setopt histignorealldups sharehistory
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=$HOME/.zsh_history
ZLE_SPACE_SUFFIX_CHARS=$'|&'

export COLORTERM="truecolor"

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

if exists gvim
then
    alias vim='gvim -v'
    alias vi='vim'
else
    alias vi='vim'
fi

if exists exa
then
    alias ls='exa'
    alias lt='exa --long --sort=old'
fi

if exists docker
then
    alias dl="docker exec --interactive --tty --user ${USER} --workdir ${HOME} $(docker ps --quiet --latest --filter 'status=running') /bin/bash --login"
fi

if exists fdfind
then
    alias fd='fdfind'
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

export PIPENV_VENV_IN_PROJECT="1"

eval "$(starship init zsh)"
