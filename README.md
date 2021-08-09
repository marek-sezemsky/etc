~/etc
=====

Marek's ~/etc configuration files (`.*rc`) for bash, Vim and others. Bundles [vim-pathogen](https://github.com/tpope/vim-pathogen) plugins.


Download and install
--------------------

Clone into your home directory:

    cd ~ && git clone --recursive git://github.com/marek-sezemsky/etc.git

Or source proxy settings first and use proxy-friendly HTTPS.

    # export HTTP_PROXY=http://
    cd ~ && git clone --recursive https://marek-sezemsky@github.com/marek-sezemsky/etc.git

Install (or update) with:

    cd ~ && etc/install


~/etc.d/*
----------

Untracked directory for any per-site or other customized bashrc files.

All `~/etc.d/*/bashrc` files will be sourced.


Binaries
--------

Worthwhile scripts:

* `~/etc/install` - installation script
* `~/etc/sync` - pull submodules recursively


