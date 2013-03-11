#!/bin/bash
#
# Install listed $1/ files as hidden symlinks into current directory.
# Overwrite existing symlinks.
#
# cd $HOME && marek-etc/install.sh marek-etc/
#

set -e
set -u
#set -x

# files to install
files="bashrc vimrc"

if [ -z "${1:-}" ]; then
    echo "Usage: $0 <src>" >&2
    exit 1
else
    src=$1
fi


link()
{
    file="$src/$1"
    link=".$1"

    if [ -h $link ]; then
        ln -sfn $file $link
        echo "installed $link -> $file"
    else
        echo "skipped $link"
    fi
}


for file in $files; do
    link $file
done
