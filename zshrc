function exists { which $1 &> /dev/null }

if exists brew
then
    if ! exists pip3
    then
        brew install python3
    fi
    if ! exists powerline-daemon
    then
        $(brew --prefix)/bin/pip3 install powerline-status
    fi
    powerline-daemon -q
    source "$(brew --prefix)/lib/python3.7/site-packages/powerline/bindings/zsh/powerline.zsh"
fi

setopt histignorealldups sharehistory

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
case "$OSTYPE" in
    linux*)
        eval "$(dircolors -b)";;
    darwin*)
        eval "$(gdircolors -b)";;
esac
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

alias R='R --no-save'
case "$OSTYPE" in
    linux*)
        alias ls='ls -F --group-directories-first --color=auto';;
    darwin*)
        alias ls='gls -F --group-directories-first --color=auto';;
esac
if [ -f $HOME/.aliases ]
then
    source $HOME/.aliases
fi


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


if exists peco
then
    function peco-ssh() {
        BUFFER="ssh $(cat ~/.ssh/config \
            | grep -e '^Host' \
            | sed -e 's/^Host[ \t]//' \
            | grep -v '^\(\*\|github.com\)$' \
            | peco --prompt='ssh> ')"
        CURSOR=$#BUFFER
        zle reset-prompt
    }
    zle -N peco-ssh
    bindkey '^T' peco-ssh

    function peco-history() {
        BUFFER="$(history -n -r 1 | peco --prompt='history> ' --query="$LBUFFER")"
        CURSOR=$#BUFFER
        zle reset-prompt
    }
    zle -N peco-history
    bindkey '^R' peco-history

    if exists fd
    then
        function peco-find() {
            BUFFER="$(fd --max-depth=6 --hidden --follow --exclude '.git' \
                | peco --prompt='fd> ' --query="$LBUFFER")"
            CURSOR=$#BUFFER
            zle reset-prompt
        }
        zle -N peco-find
        bindkey '^X^F' peco-find
    fi

    if exists psql
    then
        function peco-postgres() {
            local pgpass="$HOME/.pgpass"
            if [ -f $pgpass ]
            then
                touch $pgpass
                chmod 600 $pgpass
            fi
            BUFFER="$(cat $pgpass \
                | grep -v '^#' \
                | awk 'BEGIN { FS = ":"; OFS = ":"; } { print $1, $2, $3, $4 }' \
                | column -s':' -t \
                | peco --prompt='postgres> ' \
                | sed -e 's/ \{2,\}/ /g' \
                | awk 'BEGIN { FS = " "; OFS = " "; } { print "psql -h", $1, "-p", $2, "-U", $4, "-d", $3; }')"
            CURSOR=$#BUFFER
            zle reset-prompt
        }
        zle -N peco-postgres
        bindkey '^X^P' peco-postgres
    fi
fi

if exists tmux && [ -z "$TMUX" ] && [ -z "$SSH_CONNECTION" ]
then
    tmux
fi
