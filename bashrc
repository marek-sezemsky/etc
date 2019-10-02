# ~/.bashrc

# source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# history control
HISTCONTROL=ignorespace:ignoredups
HISTIGNORE=ls:ll:la:l:cd:pwd:exit:mc:su:df:clear

export PATH="$PATH:$HOME/local/bin:$HOME/bin"        # home
export PATH="$PATH:/usr/local/sbin:/usr/sbin:/sbin"  # sysop
export PATH="$PATH:/usr/local/bin:/usr/bin:/bin"     # system

# alias to auto color when able
if ls --color=auto /dev/null &> /dev/null ; then
    # use colors only when supported by ls
    alias grep='grep --color=auto'
    alias egrep='egrep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
fi

# aliases
alias p27='source ~/env/python2.7/bin/activate'
alias p36='source ~/env/python3.6/bin/activate'
alias p37='source ~/env/python3.7/bin/activate'
alias fn='find . -name'
alias pd='perldoc'
alias l='ls -Alpvis --group-directories-first --time-style=+%Y-%m-%dT%H:%M:%S,%N%:z'
alias la='l -a'
alias g='git'
alias gl='g l --no-merges'
alias gf='g flow'

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

# $DISPLAY
[ -f ~/.display ] && source ~/.display

# local definitions
[ -f ~/.bashrc_local ] && source ~/.bashrc_local

# vim:ft=sh
