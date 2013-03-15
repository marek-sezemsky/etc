#!/bin/bash
#
# Pull or install handy VIM plugins from URLs recieved on STDIN into given 
# directory.
# 
# git-pull.sh bundle
#

set -e
set -u
#set -x

# config
github_url="https://github.com/vim-scripts/"
[ -r ~/.proxy ] && source ~/.proxy

# args
base="${1:-bundle}"

while read url; do
    dir="$base/$(basename $url)"
    #dir="${dir%.git}"
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

