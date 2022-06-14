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

Source from ~/.bashrc:

    # User specific aliases and functions
    if [ -f ~/etc/bashrc ]; then
        source ~/etc/bashrc
    fi


Binaries
--------

Worthwhile scripts:

* `~/etc/install` - installation script
* `~/etc/sync` - pull submodules recursively


