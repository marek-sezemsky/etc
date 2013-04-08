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

    if [ ! -d "$dir" ]; then
        git clone "$url" "$dir"
    else
        fhead="$dir/.git/FETCH_HEAD"
        if [ -f "$fhead" ] && [ -n "$(find $fhead -mtime -1)" ]; then
            echo "Fetched recently."
            return
        else
            old="$(pwd)"
            cd "$dir"
            git pull
            cd "$old"
        fi
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
