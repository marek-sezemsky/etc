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
export PATH="$PATH:/usr/local/bin:/usr/bin:/bin"     # system
export PATH="$PATH:/usr/local/sbin:/usr/sbin:/sbin"  # sysop
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
if [ -r ~/.bash_aliases ]; then
    source ~/.bash_aliases
fi

if [ -r ~/.git-prompt.sh ]; then
    source ~/.git-prompt.sh
fi

# load fancy Bash prompt
if [ -r ~/.bash_ps1 ]; then
    source ~/.bash_ps1
fi

# load ~/etc.d/*/bashrc files
for bashrc in $(ls ~/etc.d/*/bashrc 2>/dev/null); do
    source ${bashrc}
done
unset bashrc

