# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'

PS1='\w 󰘧 '

export PATH=$PATH:/home/empee/.dotnet/tools
export TERM=xterm-256color

if [ -f ~/.local.bashrc ]; then
    source ~/.local.bashrc
fi
