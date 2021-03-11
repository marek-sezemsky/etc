# ~/.bashrc

# load system definitions
if [ -r /etc/bashrc ]; then
    source /etc/bashrc
fi

# load system git completion
if [ -r /etc/bash_completion.d/git ]; then
    source /etc/bash_completion.d/git
fi

# adjust paths, bring in everything
export PATH="$PATH:$HOME/usr/local/bin:$HOME/usr/bin:$HOME/bin" # home
export PATH="$PATH:/usr/local/sbin:/usr/sbin:/sbin"             # sysop
export PATH="$PATH:/usr/local/bin:/usr/bin:/bin"                # system

# history control
export HISTCONTROL=ignorespace:ignoredups
export HISTIGNORE=l:v:vv:vvv:vvvv:s:d:dc:ll:cd:pwd
export HISTSIZE=4096
export HISTFILESIZE=32768

# --RAW-CONTROL-CHARS: allow ANSI "color" escape sequences
export LESS="-R"

# make vim default editor if present
if which vim &>/dev/null; then
    export EDITOR=vim
fi

# bash options
shopt -s autocd
shopt -s cdspell
shopt -s direxpand
shopt -s cmdhist # multiple-line command in the same history entry
shopt -s lithist # embedded newlines rather than semicolon separators

# load user aliases
if [ -r ~/.bash_aliases ]; then
    source ~/.bash_aliases
fi

# load fancy Git prompt
if [ -r ~/.git-prompt.sh ]; then
    export GIT_PS1_SHOWDIRTYSTATE=1
    export GIT_PS1_SHOWUNTRACKEDFILES=1
    export GIT_PS1_SHOWUPSTREAM=auto
    source ~/.git-prompt.sh
fi

# load fancy Bash prompt
if [ -r ~/.bash_ps1 ]; then
    source ~/.bash_ps1
fi

# load bashrc_local_* files (ignore backups~)
for bashrc_local in $(ls ~/.bashrc_local* 2>/dev/null); do
    if [[ ! ${bashrc_local} =~ ~$ && -r ${bashrc_local} ]]; then
        source ${bashrc_local}
    fi
done
unset bashrc_local

# vim:ft=sh
