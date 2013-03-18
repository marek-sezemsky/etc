#!/bin/bash
#
# Install marek-etc files as hidden symlinks into target directory.
#
# marek-etc/install.sh $HOME
#

set -e
set -u
#set -x

# files/directories to install
links="bashrc bash_profile vimrc vim"

stderr() # prints stderr message {{{
{
    echo "$(basename $0): $*" >&2
} # }}}

source_dir() # return path to source directory {{{
{
    cd $(dirname $0)
    local source=$(pwd -P)

    echo $source
} # }}}

link() # create/overwrites SRC DST symlink {{{
{
    local src="${1:-}"
    local dst="${2:-}"
    [ -e "$src" ] && [ -n "$dst" ]

    if [ -h "$dst" ] || [ ! -e "$dst" ]; then
        ln -sfn "$src" "$dst"
        echo "$dst -> $src"
    else
        stderr "Skipped: $dst"
    fi
} # }}}

dst=${1:-}
if [ -z "$dst" ]; then
    stderr "Usage: $0 <dst>"
    exit 1
fi

src=$(source_dir)
for file in $links; do
    link "$src/$file" "$dst/.$file"
done
