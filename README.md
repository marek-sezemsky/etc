# `~/etc`

Marek's tailored `~/etc` configuration files (`.*rc`) for bash, Vim and others. Bundles [vim-pathogen](https://github.com/tpope/vim-pathogen) plugins, powershell and much more.

## bootstrap

```bash
# export HTTP_PROXY=http://..?
( apt-get update && apt-get install bash vim git mc ) ||
( yum install bash vim git mc )                       ||
( dnf install bash vim git mc )

cd ~
git clone --recursive git://github.com/marek-sezemsky/etc.git || 
git clone --recursive https://marek-sezemsky@github.com/marek-sezemsky/etc.git

etc/install

cat >> ~/.bashrc <<EOF
# User specific aliases and functions
if [ -f ~/etc/bashrc ]; then
  source ~/etc/bashrc
fi

EOF

source ~/etc/bashrc ||
exec bash
```

Binaries
--------

Worthwhile scripts:

* `~/etc/install` - installation script
* `~/etc/sync` - pull submodules recursively


