bindkey -e

export LANGUAGE=en_US.UTF-8
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

setopt histignorealldups sharehistory
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=$HOME/.zsh_history
ZLE_SPACE_SUFFIX_CHARS=$'|&'

FPATH="$HOME/.zfunc:$FPATH"
exists brew && FPATH="$(brew --prefix)/share/zsh-completions:$(brew --prefix)/share/zsh/site-functions:$FPATH"

autoload -Uz compinit && compinit

if exists fzf
then
    export FZF_DEFAULT_OPTS="--exact --layout=reverse --info='hidden' --pointer='> ' --color='bg+:#333333' --no-sort"
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
        DOCKER_PS_FORMAT='{{.ID}} ({{ .Names }}) {{ .Image }} {{ .Status }} {{ .CreatedAt }}'
        # Run a Docker container
        function di() {
            local selected=$(
                docker images --format "{{ .Repository }}:{{ .Tag }}" \
                | fzf --prompt='images> ' --query "$LBUFFER"
            )
            local image="$(echo $selected)"
            local names=("mercury" "venus" "mars" "jupiter" "saturn" "uranus" "neptune")
            local name=$names[$(( 1 + ($RANDOM % ${#names[@]}) ))]
            if [ -z "$image" ]
            then
                return
            fi
            print -z "docker run --name $name -d -it --entrypoint /bin/sh $image"
        }
        # Connect to a Docker container
        function dl() {
            local selected=$(
                docker container ls --all --format "$DOCKER_PS_FORMAT" \
                | fzf --prompt='container> ' --query "$LBUFFER"
            )
            local container_id="$(echo $selected | cut -d' ' -f1)"
            local image="$(echo $selected | cut -d' ' -f3)"
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
            | grep -v '^github.com$' \
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
                    echo "${host} ${user} ${identityfile} ${hostname}"
                done;
              ) \
            | fzf --prompt 'host> '
        )
        if [ -n "$selected" ]
        then
            print -z "ssh $(echo $selected | sed -e 's/^\([^ ]\+\) \([^ ]\+\) .*/\2@\1/')"
        fi
    }

    if exists rbenv
    then
        function rs() {
            local selected=$(
                rbenv versions --bare \
                | tr -d ' ' \
                | fzf --prompt='ruby> ' --query "$LBUFFER"
            )
            if [ -n "$selected" ]
            then
                print -z "rbenv shell $(echo $selected)"
            fi
        }
    fi

    if exists pyenv
    then
        function pe() {
            local selected=$(
                pyenv versions --bare \
                | fzf --prompt='python> ' --query "$LBUFFER"
            )
            if [ -n "$selected" ]
            then
                print -z "pyenv local $(echo $selected)"
            fi
        }
    fi

    if exists aws
    then
        function ec2() {
            local query='Reservations[].Instances[].[InstanceId, InstanceType, State.Name, PublicDnsName]'
            local selected=$(
                aws ec2 describe-instances --query $query --output=text \
                | column -t --output-separator=' ' \
                | fzf --prompt='ec2> ' --query "$LBUFFER"
            )
            if [ -n "$selected" ]
            then
                local instance_id=$(echo $selected | cut --delimiter=' ' -f1)
                local hostname=$(echo $selected | cut --delimiter=' ' -f4)
                if [[ $selected == *stopped* ]]
                then
                    print -z "aws ec2 start-instances --instance-ids $instance_id"
                else
                    echo "Choose an action (ssh|stop|terminate) for $instance_id."
                    read "choice?> "
                    case $choice in
                        ssh)
                            if [ -n "$hostname" ]
                            then
                                sed -i "s/Hostname\s\+ec2-.*/Hostname $hostname/" ~/.ssh/config
                                print "\`Hostname\` has been set to \`${hostname}\`."
                            fi
                            ;;
                        stop)
                            print -z "aws ec2 stop-instances --instance-ids $instance_id"
                            ;;
                        terminate)
                            print -z "aws ec2 terminate-instances --instance-ids $instance_id"
                            ;;
                        *)
                            ;;
                    esac
                fi
            fi
        }
    fi
fi

# GCP
[ -f "$HOME/google-cloud-sdk/path.zsh.inc" ] && source "$HOME/google-cloud-sdk/path.zsh.inc"
[ -f "$HOME/google-cloud-sdk/completion.zsh.inc" ] && source "$HOME/google-cloud-sdk/completion.zsh.inc"

exists R && alias R='R --no-save'
exists eza && alias ls='eza'
exists fdfind && alias fd='fdfind'
case "$OSTYPE" in
    linux*)
        exists gvim && alias vim='gvim -v'
        exists vim && alias vi='vim'
        exists wl-copy && alias pbcopy='wl-copy'
        ;;
esac

# Make sure that VcXsrv is running and allowed to communicate with WSL2 by Windows Firewall
if [ -f "/proc/version" ] && grep -q -i "microsoft" "/proc/version"
then
    local local_ip="$(cat /etc/resolv.conf | grep nameserver | awk '{ print $2 }')"
    export DISPLAY="$local_ip:0.0"
fi

exists tmux && [ -z "$TMUX" ] && [ -z "$SSH_CONNECTION" ] && tmux

exists starship && eval "$(starship init zsh)"
