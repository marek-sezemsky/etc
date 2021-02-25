# ~/.bashrc

# source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# don't trust distros!
umask 022

# history control
export HISTCONTROL=ignorespace:ignoredups
export HISTIGNORE=ls:ll:la:l:cd:pwd:exit:mc:su:df:clear

export PATH="$PATH:$HOME/usr/local/bin:$HOME/usr/bin:$HOME/bin" # home
export PATH="$PATH:/usr/local/sbin:/usr/sbin:/sbin"             # sysop
export PATH="$PATH:/usr/local/bin:/usr/bin:/bin"                # system

# --RAW-CONTROL-CHARS: allow ANSI "color" escape sequences
export LESS="-R"

if which vim &>/dev/null; then
    export EDITOR=vim
fi

# git bash completion
if [ -f "/etc/bash_completion.d/git" ]; then
    if ! type _git >/dev/null 2>&1
    then
        source "/etc/bash_completion.d/git"
    fi
    complete -o default -o nospace -F _git g
fi

# fancy Git prompt
export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWUNTRACKEDFILES=1
export GIT_PS1_SHOWUPSTREAM=auto
[ -f ~/.git-prompt.sh ] && source ~/.git-prompt.sh

# fancy Bash prompt
[ -f ~/.bash_ps1 ] && source ~/.bash_ps1

# load aliases
[ -f ~/.bash_aliases ] && source ~/.bash_aliases

# local definitions
for bashrc_local in $(ls -1 ~/.bashrc_local* 2>/dev/null); do
    # ignore backup files
    if [[ ! ${bashrc_local} =~ ~$ ]]; then
        source ${bashrc_local}
    fi
done
unset bashrc_local

# vim:ft=sh
