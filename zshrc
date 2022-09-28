bindkey -e

setopt histignorealldups sharehistory
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=$HOME/.zsh_history
ZLE_SPACE_SUFFIX_CHARS=$'|&'

export COLORTERM="truecolor"

if exists fzf
then
    export FZF_DEFAULT_OPTS="--layout=reverse --info='hidden' --pointer='> ' --color='bg+:#333333' --no-sort"
    function fzf-history() {
        BUFFER=$(
            history -n -r 1 \
            | fzf --prompt='history> ' --query="$LBUFFER"
        )
        CURSOR=$#BUFFER
        zle reset-prompt
    }
    zle -N fzf-history
    bindkey -r '^R'
    bindkey '^R' fzf-history

    if exists docker
    then
        DOCKER_PS_FORMAT='🐋{{.ID}} ({{ .Names }}) 📀{{.Image }} ⌛{{ .Status }} ⏰{{ .CreatedAt }}'
        # Connect to a Docker container
        function dl() {
            local selected=$(
                docker container ls --all --format "$DOCKER_PS_FORMAT" \
                | fzf --prompt='container> ' --query "$LBUFFER"
            )
            local container_id="$(echo $selected | sed -e 's/^🐋\([^ ]\+\).*/\1/')"
            local image="$(echo $selected | sed -e 's/^[^📀]\+📀\([^ ]\+\).*/\1/')"
            if [ -z "$container_id" ] || [ -z "$image" ]
            then
                return
            fi
            case "$image" in
                postgres*)
                    local user="postgres"
                    local workdir="/var/lib/postgresql"
                    ;;
                *)
                    local user="root"
                    local workdir="/"
                    ;;
            esac
            print -z "docker exec -it -u $user -w $workdir $container_id /bin/bash --login"
        }
    fi

    function sf() {
        if [ ! -e $HOME/.ssh/config ]
        then
            return
        fi

        local selected=$(
            grep '^Host' $HOME/.ssh/config \
            | sed -e 's/^Host //' \
            | grep -v '^github$' \
            | grep -v '^\*$' \
            | (
                while read -r host
                do
                    local user=$(ssh -tt -G $host | grep '^user ' | sed -e 's/^user //')
                    local hostname=$(ssh -tt -G $host | grep '^hostname ' | sed -e 's/^hostname //')
                    local identityfile=$(
                        ssh -tt -G $host \
                        | grep '^identityfile ' \
                        | sed -e 's/^identityfile //' \
                        | xargs -n1 basename
                    )
                    echo "💻${host} 🙂${user} 🔑${identityfile} 🌏${hostname}"
                done;
              ) \
            | fzf --prompt 'host> '
        )
        if [ -n "$selected" ]
        then
            print -z "ssh $(echo $selected | sed -e 's/^💻\([^ ]\+\) 🙂\([^ ]\+\) .*/\2@\1/')"
        fi
    }

    if exists rbenv
    then
        function rs() {
            local selected=$(
                rbenv versions --bare \
                | tr -d ' ' \
                | sed -e 's/^/💎 /' \
                | fzf --prompt='ruby> ' --query "$LBUFFER"
            )
            if [ -n "$selected" ]
            then
                print -z "rbenv shell $(echo $selected | sed -e 's/💎 //')"
            fi
        }
    fi

    if exists pyenv
    then
        function pe() {
            local selected=$(
                pyenv versions --bare \
                | sed -e 's/^/🐍 /' \
                | fzf --prompt='python> ' --query "$LBUFFER"
            )
            if [ -n "$selected" ]
            then
                print -z "pyenv local $(echo $selected | sed -e 's/🐍 //')"
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

case "$OSTYPE" in
    linux*)
        alias pbcopy='xclip'
        ;;
esac

# Make sure that VcXsrv is running and allowed to communicate with WSL2 by Windows Firewall
if [ -f "/proc/version" ] && grep -q -i "microsoft" "/proc/version"
then
    local local_ip="$(cat /etc/resolv.conf | grep nameserver | awk '{ print $2 }')"
    export DISPLAY="$local_ip:0.0"
fi

exists tmux && [ -z "$TMUX" ] && [ -z "$SSH_CONNECTION" ] && tmux

export PIPENV_VENV_IN_PROJECT="1"

exists starship && eval "$(starship init zsh)"
