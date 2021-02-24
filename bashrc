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

# alias to auto color when able
if ls --color=auto /dev/null &>/dev/null ; then
    # use colors only when supported by ls
    alias grep='grep --color=auto'
    alias egrep='egrep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
fi

# cd aliases
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../../'

# aliases
alias a='ansible'
alias ai='ansible-inventory'
alias ap='ansible-playbook'
alias co='g co'
alias ci='g ci'
alias d='docker'
alias fn='find . -name'
alias g='git'
alias gf='g flow'
alias gl='g l --no-merges'
alias l='ls -a -l -v --inode --size --time-style=+%Y-%m-%dT%H:%M:%S%:z'
alias la='l -a'
alias ll='ls -l'
alias ltr='l -tr'
alias p='podman'
alias pd='perldoc'
alias pull='g pull'
alias push='g push'
alias se='source env/bin/activate'
alias vimo='vim -o'
alias vimO='vim -O'
alias t='terraform'

# git bash completion
if [ -f "/etc/bash_completion.d/git" ]; then
    if ! type _git >/dev/null 2>&1
    then
        source "/etc/bash_completion.d/git"
    fi
    complete -o default -o nospace -F _git g
fi

# --RAW-CONTROL-CHARS: allow ANSI "color" escape sequences
export LESS="-R"

if which vim &>/dev/null; then
    export EDITOR=vim
fi

# fancy Git prompt
export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWUNTRACKEDFILES=1
export GIT_PS1_SHOWUPSTREAM=auto
[ -f ~/.git-prompt.sh ] && source ~/.git-prompt.sh

# fancy Bash prompt
[ -f ~/.bash_ps1 ] && source ~/.bash_ps1

# local definitions
for bashrc_local in $(ls -1 ~/.bashrc_local* 2>/dev/null); do
    # ignore backup files
    if [[ ! ${bashrc_local} =~ ~$ ]]; then
        source ${bashrc_local}
    fi
done
unset bashrc_local

# vim:ft=sh
