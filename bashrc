# ~/etc/bashrc
#
# this file is typically sourced from user's ~/.bashrc
#

# append generic system paths /usr/local, usr and bin sbin
export PATH="$PATH:/usr/local/bin:/usr/bin:/bin"     # system
export PATH="$PATH:/usr/local/sbin:/usr/sbin:/sbin"  # sysop

# prepend user home and local bin
export PATH="$HOME/bin:$HOME/local/bin:$PATH"        # home

# history control
export HISTCONTROL=ignoredups
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
if [ -r ~/etc/bash_aliases ]; then
    source ~/etc/bash_aliases
fi

if [ -r ~/etc/git-prompt.sh ]; then
    source ~/etc/git-prompt.sh
fi

# load fancy Bash prompt
if [ -r ~/etc/bash_ps1 ]; then
    source ~/etc/bash_ps1
fi

# load ~/etc.d/*/bashrc files
for bashrc in $(ls ~/etc.d/*/bashrc 2>/dev/null); do
    source ${bashrc}
done
unset bashrc

