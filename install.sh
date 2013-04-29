#!/bin/bash
#
# Install into home.
#
# ~/etc/install.sh
#

set -e
set -u
#set -x

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
        echo "symlink $dst -> $src"
        ln -sfn "$src" "$dst"
    else
        echo "skip: $dst exists"
    fi
} # }}}

git_conf() # setup global git configuration value {{{
{
    local gc="git config --replace --global"
    local name="$1"
    shift
    local value="$*"

    echo $gc $name \"$value\"
    $gc $name "$*"
} # }}}

src=$(get_source_dir)
dst=~
have_git="$(which git)"

echo "# link $src into home"
links="bashrc bash_profile vimrc vim screenrc rpmmacros"
for file in $links; do
    mklink "$src/$file" "$dst/.$file"
done

echo "# setup git configuration and aliases"
if [ -n "$have_git" ]; then
    git_conf color.ui true
    git_conf core.excludesfile "$src/gitignore_global"
    git_conf log.decorate short
    git_conf alias.co checkout
    git_conf alias.br branch
    git_conf alias.ci commit
    git_conf alias.st status
    git_conf alias.di diff
    git_conf alias.dc diff --cached
    git_conf alias.l  log --all --oneline --graph --decorate -20
    git_conf alias.s  status --short --branch
else
    echo "skip: git not installed"
fi

echo "# git-pull vim bundles"
if [ -h $dst/.vim ]; then
    $src/vim/git-pull.sh $src/vim/bundle
else
    echo "skip: $dst/.vim is not symlink"
fi
