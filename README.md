~/etc
=====

Marek's ~/etc profile files and Vim configuration repository.

Instalation
-----------

Clone into home directory:

    . ~/.proxy
    git clone https://marek-sezemsky@github.com/marek-sezemsky/etc.git

and install (or update) with:

    ~/etc/install.sh

Vim
---
Installation will also clone/pull vim bundles (pathogen plugins) as listed in
`vim/plugins`. Custom code snippets are located in `vim/snippets/`.

Extras
------

Setup local bash additions (work, home, ...):

    ln -s ~/etc/bashrc_local_work ~/.bashrc_local

SecureCRT
---------

To source my bash profile for shared accounts (like vobadm, ccm_root,
builder), create forced profile that will change $HOME during sourcing of
.bash_profile (change 'marek' to whoever you are on the machine) and setup
SecureCRT's 'automated' login:

* Expect: ` ~]`  # [vobadm@box ~]$ or [root@box ~]#
* Send:   `exec bash -rcfile ~marek/.bash_profile_forced`

Create forced profile - `$HOME` will be hardcoded in this file:

    cat > ~/.bash_profile_forced <<EOF
    real=\$HOME
    HOME=$HOME  # $HOME of whoever created this file
    . ~/.bash_profile
    HOME=\$real
    unset real
    EOF
