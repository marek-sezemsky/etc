marek-etc
=========

Marek's ~/etc profile files.

Instalation
-----------

Clone into home directory:

    git clone git@github.com:marek-sezemsky/marek-etc.git ~/etc

and install (or update) with:

    ~/etc/install.sh

Extras
------

Setup local bash additions (work, home, ...):

    ln -s ~/etc/bashrc_local_work ~/.bashrc_local

SecureCRT
---------

Source bash profile with sessions to shared accounts (vobadm, ccm_root,
builder) via automated login (change 'marek' to whoever you are):

* Expect: ` ~]`  # [vobadm@cc ~]$ or [root@box ~]#
* Send:   `exec bash -rcfile ~marek/.bash_profile_forced`

and create forced profile in your home:

    cat > ~/.bash_profile_forced <<EOF
    real=\$HOME
    HOME=$HOME  # home of whoever created this
    . ~/.bash_profile
    HOME=\$real
    unset real
    EOF
