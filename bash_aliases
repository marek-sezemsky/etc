# ~/.bash_aliases

# useful
# (-v=natural number sort; -o/-l listing modes)
alias _l='ls -v --size --group-directories-first'
alias  l='_l --almost-all -o'
alias ll='_l --all -l --inode --time-style=+%Y-%m-%dT%H.%M.%SZ%z'
alias fn='find . -name'
alias se='source env/bin/activate'
alias t='terraform'
alias kc='kubectl'
alias h='helm'
alias vimO='vim -O'
alias vimo='vim -o'
alias o='vim -o'
alias O='vim -O'
alias e=o
alias E=O
alias D=vimdiff

# git aliases; replacing ct=cleartool + mt=multitool; RIP ClearCase, you will be missed
alias g='git'
# see also ~/etc/install for configured git shortcuts; both 's' and 'g s' work
alias a='git add'
alias ai='git add --interactive'
alias au='git add --update'
alias br='git branch'
alias ci='git commit --verbose'
alias co='git checkout'
alias d='git diff'
alias dc='git diff --cached' # (eclipses /bin/dc: an arbitrary precision calculator)
alias gg='git grep -n'
alias v='git --no-pager log --abbrev --pretty=onelinedate --date=relative --decorate -30'
alias vv='git log --abbrev --pretty=onelinedate --date=relative --decorate --graph'
alias pull='git pull'
alias push='git push'
alias s='git status --short --branch'
alias show='git show'

# add bash completion to the aliases too
if type __git_complete __git_main &>/dev/null; then
    # main 'g';
    __git_complete g __git_main
    # command shortcuts;
    __git_complete a  _git_add
    __git_complete ai _git_add
    __git_complete au _git_add
    __git_complete br _git_branch
    __git_complete ci _git_commit
    __git_complete co _git_checkout
    __git_complete d  _git_diff
    __git_complete dc _git_diff
    __git_complete gg _git_grep
    __git_complete pull _git_pull
    __git_complete push _git_push
    __git_complete s    _git_status
    __git_complete show _git_show
    __git_complete v  _git_log
    __git_complete vv _git_log
fi

# quick switch-to-current-master
alias master='git checkout master && git pull --prune && git status'

# quick cd up
alias  ...='cd ../../'
alias ....='cd ../../../../'
