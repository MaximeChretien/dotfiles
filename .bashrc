# .bashrc

export PATH="$HOME/.local/bin:$PATH"
export EDITOR=vim
export HISTSIZE=100000

bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

export TSRC_PARALLEL_JOBS=1

# Commands aliases
alias clc="cd ~ && clear"

# Folder aliases

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# SSH agent
if ! pgrep -u "$USER" ssh-agent > /dev/null; then
    ssh-agent -t 1h > "$XDG_RUNTIME_DIR/ssh-agent.env"
fi
if [[ ! -f "$SSH_AUTH_SOCK" ]]; then
    source "$XDG_RUNTIME_DIR/ssh-agent.env" >/dev/null
fi

# Fixing vte issue for Tilix
if [ $TILIX_ID ] || [ $VTE_VERSION ]; then
        source /etc/profile.d/vte.sh
fi

alias ls='ls --color=auto'
PS1='\[\e[0;1;38;5;28m\]{\[\e[0;1;38;5;40m\]\u\[\e[0;1;38;5;28m\]@\[\e[0;1;38;5;40m\]\H \[\e[0;1;38;5;39m\]\W \[\e[0;38;5;91m\](\[\e[0;1;38;5;98m\]\j\[\e[0;1;38;5;91m\])\[\e[0;1;38;5;28m\]} \[\e[0;1;38;5;40m\]$ \[\e[0m\]'
