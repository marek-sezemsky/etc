#!/bin/bash
#
# Pull or install handy VIM plugins into given destination directory.
# 
# git-pull.sh bundle < plugins
#

set -e
set -u
#set -x

[ -r ~/.proxy ] && source ~/.proxy

stderr() {
    echo "$(basename $0): $*" >&2
}

dst="${1:-}"
if [ -z "${1:-}" ]; then
    stderr "Usage: $0 <dst> < urls"
    exit 1
fi

while read url; do
    dir="$dst/$(basename $url)"
    dir="${dir%.git}"

    echo "Pulling: $dir [$url]"
    if [ -d "$dir/.git" ]; then
        old="$(pwd)"
        cd "$dir"
        git pull
        cd "$old"
    else
        git clone "$url" "$dir"
    fi
done
