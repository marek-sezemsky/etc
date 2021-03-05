# ~/.bash_aliases

# useful
alias l='ls -A -l -v --inode --size --time-style=+%Y-%m-%dT%H:%M:%S%:z --group-directories-first'
alias ll='ls -l'
alias fn='find . -name'
alias se='source env/bin/activate'
alias t='terraform'
alias vimO='vim -O'
alias vimo='vim -o'

# git aliases;
# see also ~/etc/install for configured git shortcuts
alias g='git'
alias pull='git pull'
alias push='git push'
alias au='git add --update'
if type __git_complete __git_main &>/dev/null; then
    __git_complete g __git_main
fi

# cd aliases
alias ..='cd ..'
alias ...='cd ../..'

# vim:ft=sh
