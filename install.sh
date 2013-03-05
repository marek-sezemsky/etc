#!/bin/bash
#
# Install marek-etc files as symlinks in current directory. Overwrite existing
# symlinks.
#
# cd ~ && marek-etc/install.sh marek-etc/
#

set -e
set -u
#set -x

if [ -z "${1:-}" ]; then
	echo "Usage: $0 <src>" >&2
	exit 1
fi

src=$1

link()
{
	file="$src/$1"
	link=".$1"

	if [ ! -e $link ]; then
		ln -s $file $link
		echo "installed $link -> $file"
	else
		echo "skipped $link"
	fi
}


files="bashrc vimrc"
for file in $files; do
	link $file
done
