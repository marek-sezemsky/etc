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

if [ -z "${1:-}" ]; then
    echo "Usage: $0 <dst>" >&2
    exit 1
else
    dst=$1
fi

while read url; do
    dir="$dst/$(basename $url)"
    what="[$dir] @ $url"
    
    if [ -d "$dir/.git" ]; then
        echo pulling $what
        old=$PWD
        cd $dir
        git pull
        cd $old
    else
        echo cloning $what
        git clone $url $dir
    fi
done
