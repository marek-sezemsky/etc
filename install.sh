#!/bin/bash
#
# Install listed $1/ files as hidden symlinks into current directory and pull
# or install VIm plugins.
#
# cd $HOME && marek-etc/install.sh marek-etc
#

set -e
set -u
#set -x

# files to install
files="bashrc bash_profile vimrc vim"

stderr() {
    echo "$(basename $0): $*" >&2
}

if [ -z "${1:-}" ]; then
    stderr "Usage: $0 <src>"
    exit 1
else
    src=$1
fi

link()
{
    file="$src/$1"
    link=".$1"

    if [ ! -e $link ]; then
        ln -sfn $file $link
        echo "Installed: $link -> $file"
    else
        stderr "Warning: Skipped existing $link"
    fi
}


for file in $files; do
    link $file
done

vim="$src/vim"
$vim/git-pull.sh $vim/bundle < $vim/plugins
