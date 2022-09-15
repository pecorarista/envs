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

    if exists docker
    then
      function docker-login() {
        local container_id="$(docker ps --format '{{.ID}} | {{.Image}} | {{.Names}} | {{.Status}} | {{.CreatedAt}}' | peco --query "$LBUFFER" | cut -d ' ' -f1)"
        if [ -n "$container_id" ]
        then
          local user="$1"
          local home="$2"
          local login_shell="$3"
          BUFFER="docker exec --interactive --tty --user $user --workdir $home $container_id $login_shell --login"
          CURSOR=$#BUFFER
          zle reset-prompt
        fi
      }
      function docker-login-root() {
        docker-login 'root' '/' '/bin/bash'
      }
      function docker-login-user() {
        docker-login $USER $HOME $SHELL
      }
      zle -N docker-login-root
      bindkey "^V^R" docker-login-root

      zle -N docker-login-user
      bindkey "^V^U" docker-login-user
    fi
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

if exists R
then
    alias R='R --no-save'
fi

if exists gvim
then
    alias vim='gvim -v'
    alias vi='vim'
else
    if exists vim
    then
        alias vi='vim'
    fi
fi

if exists exa
then
    alias ls='exa'
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
