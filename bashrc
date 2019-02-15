# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

pathmunge() # {{{
{
    if [ "${2:-}" = "after" ] ; then
        export PATH=$PATH:$1
    else
        export PATH=$1:$PATH
    fi
} # }}}

# History control
HISTCONTROL=ignorespace:ignoredups
HISTIGNORE=ls:ll:la:l:cd:pwd:exit:mc:su:df:clear

# Make sure all common paths are in PATH
pathmunge "$HOME/local/bin:$HOME/bin" after
pathmunge "/usr/local/sbin:/usr/sbin:/sbin" after
pathmunge "/usr/local/bin:/usr/bin:/bin" after

# Aliases
alias p36='source ~/env/python3.6/bin/activate'

if ls --color=auto -d / > /dev/null 2>&1 ; then
    # use colors only when supported by ls
    alias grep='grep --color=auto'
    alias egrep='egrep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'

    alias watch='watch --color'
fi


alias fn='find . -name'
alias pd='perldoc'
alias l='ls -l'
alias la='ls -la'
alias g='git'
alias gl='g l --no-merges'
alias gf='g flow'

# SCM: git bash completion
if [ -f "/etc/bash_completion.d/git" ]; then
    if ! type _git >/dev/null 2>&1
    then
        source "/etc/bash_completion.d/git"
    fi
    complete -o default -o nospace -F _git g
fi

# --RAW-CONTROL-CHARS: allow ANSI "color" escape sequences
export LESS="-R"

if [ -n "$(which vim 2>/dev/null)" ]; then
    export EDITOR=vim
fi

# fancy PS1 prompt
export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWUNTRACKEDFILES=1
export GIT_PS1_SHOWUPSTREAM=auto

[ -f ~/.git-prompt.sh ] && source ~/.git-prompt.sh
[ -f ~/.bash_ps1 ] && source ~/.bash_ps1

# $DISPLAY
[ -f ~/.display ] && source ~/.display

# local definitions
[ -f ~/.bashrc_local ] && source ~/.bashrc_local

unset pathmunge

# vim:ft=sh
