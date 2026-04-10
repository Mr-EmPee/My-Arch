# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'

PS1='\w 󰘧 '

export TERM=xterm-256color

if [ -f ~/.local/.bashrc ]; then
    source ~/.local/.bashrc
fi

alias fav='~/.config/hypr/scripts/fav-search.sh'
