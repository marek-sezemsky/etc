#!/bin/bash
#
# Pull or install handy VIM plugins into given destination directory.
#
# git-pull.sh vim/bundle
#

set -e
set -u
#set -x

[ -x "$(which git)" ]
[ -f ~/.proxy ] && source ~/.proxy

# url file
git_plugins="$(dirname $0)/plugins"

stderr() # prints stderr message {{{
{
    echo "$(basename $0): $*" >&2
} # }}}

git_pull() # clone or pull url into dir {{{
{
    local url="$1"
    local dir="$2"

    if [ -d "$dir/.git" ]; then
        # fetched in last 24hr
        uptodate="$(find $dir/.git/FETCH_HEAD -mtime -1)"
        if [ -n "$uptodate" ]; then
            echo "Remote pulled recently."
            return
        fi
        old="$(pwd)"
        cd "$dir"
        git pull
        cd "$old"
    else
        git clone "$url" "$dir"
    fi
} # }}}

dst="${1:-}"
if [ -z "${1:-}" ]; then
    stderr "Usage: $0 <dst> # fetches $git_plugins"
    exit 1
fi

while read url; do
    dir="$dst/$(basename $url)"
    dir="${dir%.git}"

    echo "$url -> $dir"
    git_pull "$url" "$dir"
done < $git_plugins
