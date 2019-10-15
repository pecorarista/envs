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
case "$OSTYPE" in
    linux*)
        eval "$(dircolors -b)";;
    darwin*)
        eval "$($HOME/homebrew/bin/gdircolors -b)";;
esac
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

bindkey '^[[1~' beginning-of-line
bindkey '^[[4~' end-of-line

alias R='R --no-save'
alias python='python3'
alias vi='vim'
case "$OSTYPE" in
    linux*)
        alias ls='ls -F --group-directories-first --color=never';;
    darwin*)
        alias ls='gls -F --group-directories-first --color=never';;
esac


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
    function peco-history-selection() {
        BUFFER="$(history -n -r 1 | peco --query "$LBUFFER")"
        CURSOR=$#BUFFER
        zle reset-prompt
    }
    zle -N peco-history-selection
    bindkey '^R' peco-history-selection

    if exists fd
    then
        function peco-find() {
            BUFFER="$(fd --max-depth=6 --hidden --follow --exclude '.git' | peco --query "$LBUFFER")"
            CURSOR=$#BUFFER
            zle reset-prompt
        }
        zle -N peco-find
        bindkey '^X^F' peco-find
    fi

    if exists psql
    then
        function peco-postgres() {
            if [ -f $HOME/.pgpass ]
            then
                touch $HOME/.pgpass
                chmod 600 $HOME/.pgpass
            fi
            BUFFER="$(cat $HOME/.pgpass \
                | grep -v '^#' \
                | awk 'BEGIN { FS = ":"; OFS = ":"; } { print $1, $2, $3, $4 }' \
                | column -s':' -t \
                | peco --prompt 'SELECT CONNECTION>' \
                | sed -e 's/ \{2,\}/ /g' \
                | awk 'BEGIN { FS = " "; OFS = " "; } { print "psql -h", $1, "-p", $2, "-U", $4, "-d", $3; }')"
            CURSOR=$#BUFFER
            zle reset-prompt
        }
        zle -N peco-postgres
        bindkey '^X^P' peco-postgres
    fi
fi


if [ -z "$TMUX" ]
then
    tmux
fi
