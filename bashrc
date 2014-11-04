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
pathmunge "$HOME/local/bin:$HOME/bin"
pathmunge "/usr/local/sbin:/usr/sbin:/sbin" after
pathmunge "/usr/local/bin:/usr/bin:/bin" after

# Aliases
if ls --color=auto -d / > /dev/null 2>&1 ; then
    # use colors only when supported by ls
    alias grep='grep --color=auto'
    alias egrep='egrep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
fi

alias pd='perldoc'
alias l='ls -l'
alias la='ls -la'
alias g='git'
alias gl='g l --no-merges'
alias gf='g flow'

# SCM: git
if [ -n "$(which git 2>/dev/null)" ]; then
    if [ -f "/etc/bash_completion.d/git" ]; then
        complete -o default -o nospace -F _git g
    fi
fi

# SCM: ClearCase
cc='/opt/rational/clearcase'
if [ -d "$cc" ]; then
    pathmunge "$cc/bin" after
    alias ct='cleartool'
    alias edcs='cleartool edcs'
    alias catcs="cleartool catcs | egrep -v '^\s*(#.*)?$'"
    alias lsco='cleartool lsco -cview -short'
fi
unset cc

# --RAW-CONTROL-CHARS: allow ANSI "color" escape sequences
export LESS="-R"

if [ -n "$(which vim 2>/dev/null)" ]; then
    export EDITOR=vim
fi

# fancy PS1 prompt
[ -f ~/.git-prompt.sh ] && source ~/.git-prompt.sh
[ -f ~/.bash_ps1 ] && source ~/.bash_ps1

# $DISPLAY
[ -f ~/.display ] && source ~/.display

# local definitions
[ -f ~/.bashrc_local ] && source ~/.bashrc_local

unset pathmunge

# vim:ft=sh
