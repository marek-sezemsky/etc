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

Test:

    cd ~/etc && bash run-test.bash


Sourced files
-------------

If present, those files are sourced automatically via `~/etc/bashrc`:

* `~/.bashrc_local` - custom specific bash additions or workarounds (office, cygwin, ...)
* `~/.display` - for `$DISPLAY` value


Binaries
--------

Worthwhile scripts:

* `~/etc/install` - installation script
* `~/etc/sync` - pull submodules recursively


