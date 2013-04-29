# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

pathmunge()
{
    if [ "${2:-}" = "after" ] ; then
        export PATH=$PATH:$1
    else
        export PATH=$1:$PATH
    fi
}

# History control
HISTCONTROL=ignorespace:ignoredups
HISTIGNORE=ls:ll:la:l:cd:pwd:exit:mc:su:df:clear

# Make sure all common paths are in PATH
export PATH="$HOME/local/bin:$HOME/bin"
export PATH="$PATH:/usr/local/bin:/usr/bin:/bin"
export PATH="$PATH:/usr/local/sbin:/usr/sbin:/sbin"

# Perl
alias pd='perldoc'

# SCM: git
if [ -n "$(which git 2>/dev/null)" ]; then
    alias g='git'
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

    if [ -n "${CLEARCASE_ROOT:-}" ]; then
        cc_view="$(basename ${CLEARCASE_ROOT}) "
    else
        cc_view=""
    fi
fi
unset cc

# --RAW-CONTROL-CHARS: allow ANSI "color" escape sequences
export LESS="-R"

# fancy colors; linux only
if [ "$(uname)" = "Linux" ]; then
	alias grep='grep --color=auto'
	alias egrep='egrep --color=auto'
	alias fgrep='fgrep --color=auto'
	alias ls='ls --color=auto'
    alias grep='grep --color=auto'
fi

# PS1 color for capable terminals only
colors=$(tput colors 2>/dev/null)
if [ -n "$colors" ] && [ "$colors" -ge "8" ]; then
	off=$(tput sgr0)
	#green=$(tput setaf 2)
	#red=$(tput setaf 1)
	grey=$(tput bold ; tput setaf 0)
	yellow=$(tput setaf 3)
	bold_red=$(tput bold ; tput setaf 1)
	bold_white=$(tput bold ; tput setaf 7)
	export PROMPT_COMMAND="es=\$?; [[ \$es -eq 0 ]] && __ps1_retval='$grey' || __ps1_retval='$bold_red'"
else
    export __ps1_retval=''
    unset PROMPT_COMMAND
fi

# user@box:~$ _
# current_view_tag root@box:~# _
export PS1="\[$bold_white\]$cc_view\[$off\]\\u\[$grey\]@\[$off\]\\h\[$grey\]:\[$off\]\\w\[\$__ps1_retval\]\\$\[$off\] "

unset off grey yellow bold_red bold_white

# $DISPLAY
[ -f ~/.display ] && source ~/.display

# local definitions
[ -f ~/.bashrc_local ] && source ~/.bashrc_local

unset pathmunge
