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

if [ -z "${1:-}" ]; then
    stderr "Usage: $0 <dst>"
    exit 1
else
    dst=$1
fi

while read url; do
    dir="$dst/$(basename $url)"
    what="Pulling: $dir [$url]"
    
    echo "$what"
    if [ -d "$dir/.git" ]; then
        old=$PWD
        cd $dir
        git pull
        cd $old
    else
        git clone $url $dir
    fi
done
