#!/bin/bash
#
# Install marek-etc files as hidden symlinks into target directory.
#
# marek-etc/install.sh [$HOME]
#

set -e
set -u
#set -x

# files/directories to install
links="bashrc bash_profile vimrc vim gitignore_global screenrc"
git="/usr/bin/git"

stderr() # prints stderr message {{{
{
    echo "$(basename $0): $*" >&2
} # }}}

get_source_dir() # return path to source directory {{{
{
    cd $(dirname $0)
    local source=$(pwd -P)

    echo $source
} # }}}

mklink() # create/overwrites SRC DST symlink {{{
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

# arguments
dst=${1:-$HOME}
if [ -z "$dst" ]; then
    stderr "Usage: $0 [dst]  # destination directory (defaults to \$HOME)"
    exit 1
fi

# Link files
src=$(get_source_dir)
for file in $links; do
    mklink "$src/$file" "$dst/.$file"
done

# Set gitignore_global
git="/usr/bin/git"
gitignore="$dst/.gitignore_global"
if [ -x "$git" ]; then
    "$git" config --global core.excludesfile "$gitignore"
    echo "git.config.core.excludesfile now $gitignore"
fi

# git-pull
if [ -h ~/.vim ]; then
    $src/vim/git-pull.sh $src/vim/bundle
else
    stderr "Skipped: git-pull.sh (~/.vim is not symlink)"
fi
