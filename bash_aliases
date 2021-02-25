# ~/.bash_aliases

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
alias au='g add --update'
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

# vim:ft=sh
