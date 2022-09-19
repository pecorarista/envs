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
    bindkey -r '^R'
    bindkey '^R' peco-history

    if exists docker
    then
        DOCKER_PS_FORMAT='{{.ID}} | {{.Image}} | {{.Names}} | {{.Status}} | {{.CreatedAt}}'
        # Start a Docker container
        function ds() {
            local container_id=$(
            docker ps --all --filter 'status=exited' --format "$DOCKER_PS_FORMAT" \
                | peco --query "$LBUFFER" \
                | cut -d ' ' -f1
            )
            if [ -n "$container_id" ]
            then
                local user="$1"
                local home="$2"
                local login_shell="$3"
                print -z "docker start $container_id"
            fi
        }

        # Connect to a Docker container
        function dl() {
            local container_id=$(
            docker ps --format "$DOCKER_PS_FORMAT" \
                | peco --query "$LBUFFER" \
                | cut -d ' ' -f1
            )
            if [ -n "$container_id" ]
            then
                print -z "docker exec -it -u root --workdir / $container_id /bin/bash --login"
            fi
        }
    fi
fi

# GCP
[ -f "$HOME/google-cloud-sdk/path.zsh.inc" ] && source "$HOME/google-cloud-sdk/path.zsh.inc"
[ -f "$HOME/google-cloud-sdk/completion.zsh.inc" ] && source "$HOME/google-cloud-sdk/completion.zsh.inc"

exists gvim && alias vim='gvim -v'
exists vim && alias vi='vim'
exists R && alias R='R --no-save'
exists exa && alias ls='exa'
exists fdfind && alias fd='fdfind'
exists nvm && alias nlts='nvm use lts/gallium'

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

exists tmux && [ -z "$TMUX" ] && [ -z "$SSH_CONNECTION" ] && tmux

export PIPENV_VENV_IN_PROJECT="1"

eval "$(starship init zsh)"
