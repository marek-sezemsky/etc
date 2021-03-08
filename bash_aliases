# ~/.bash_aliases

# cd aliases
alias ..='cd ..'
alias ...='cd ../..'

# useful
alias l='ls -A -l -v --inode --size --time-style=+%Y-%m-%dT%H:%M:%S%:z --group-directories-first'
alias ll='ls -l'
alias fn='find . -name'
alias se='source env/bin/activate'
alias t='terraform'
alias rp='realpath'
alias vimO='vim -O'
alias vimo='vim -o'

# git aliases; replacing ct=cleartool + mt=multitool
# see also ~/etc/install for configured git shortcuts
alias g='git'
alias au='git add --update'
alias br='git branch'
alias ci='git commit --verbose'
alias co='git checkout'
alias pull='git pull'
alias push='git push'
alias s='git status --short --branch'
if type __git_complete __git_main &>/dev/null; then
    __git_complete g __git_main
    __git_complete au _git_add
    __git_complete br _git_branch
    __git_complete ci _git_commit
    __git_complete co _git_checkout
    __git_complete pull _git_pull
    __git_complete push _git_push
    __git_complete s _git_status
fi

# vim:ft=sh
