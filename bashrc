# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# ignore duplicate
HISTCONTROL=ignoreboth
# ignore these commands in history file
HISTIGNORE=ls:ll:la:l:cd:pwd:exit:mc:su:df:clear

# User specific aliases and functions
alias g='git'
# Autocomplete for 'g' as well
complete -o default -o nospace -F _git g

alias grep='grep --color=auto'

Color_Off='\e[0m'       # Text Reset
BBlack='\e[1;30m'       # Black

export PS1="\[$Color_Off\]\u\[$BBlack\]@\[$Color_Off\]\h\[$BBlack\]:\[$Color_Off\]\w\$ "
