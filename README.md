~/etc
=====
Marek's ~/etc configuration files (`.*rc`) for bash, Vim and others.

Download and install
--------------------
Clone into your home directory:

    git clone git://github.com/marek-sezemsky/etc.git

Or source proxy settings first and use proxy-friendly HTTPS.

    # export HTTP_PROXY=http://
    cd ~ && git clone https://marek-sezemsky@github.com/marek-sezemsky/etc.git

Install (or update) with:

    cd ~ && etc/install

Test:

    cd ~/etc && bash run-test.bash

Extras
------
Setup local bash additions or workarounds (office, cygwin, ...):

    ln -s ~/etc/bashrc_local_office ~/.bashrc_local
    ln -s ~/etc/proxy/clearstream ~/.proxy

Using from shared accounts
--------------------------
To use ~/etc profile when logging to accounts where default profile is always
kept (like vobadm), use two-step hack: as first create bash with profile
sourced with changed $HOME.

    cat > ~/.bash_profile_forced <<EOF
    real=\$HOME
    HOME=$HOME  # $HOME evals to ~
    . ~/.bash_profile
    HOME=\$real
    unset real
    EOF

And once logged into shared account, exec shell again:

    [vobadm@box ~]$  exec bash -rcfile ~marek/.bash_profile_forced

This may be used with SecureCRT Automated login (or `expect`) to wait for `~]`
(as example for RHEL-based machines) and launching the same command as above.
