>***If you are not me, this is very probably very useless for you. Not your generic 'dotfiles' repository.***
# `~/etc`


Marek's tailored `~/etc` configuration files (`.*rc`) for bash, Vim and others. Bundles [vim-pathogen](https://github.com/tpope/vim-pathogen) plugins, powershell and much more.

Seen in vild in (RH)EL/Fedora, *bian, *buntu, Slackware, WSL (EL,deb.).

## `BOOTSTRAP.EXE`

```bash
# export HTTP_PROXY=http://..?
sudo bash -c "( yum     install bash vim git mc                       ctags ) ||
              ( dnf     install bash vim git mc                       ctags ) ||
              ( apt-get install bash vim git mc {exuberant,universal}-ctags ) ||
                   echo install bash vim git mc {exuberant,universal}-ctags"
```

```bash
# clone & install
cd ~
git clone --recursive   git://github.com/marek-sezemsky/etc.git || 
git clone --recursive https://github.com/marek-sezemsky/etc.git

etc/install
```

```bash
# append to ~/.bashrc
cat >> ~/.bashrc <<EOF
# User specific aliases and functions
if [ -f ~/etc/bashrc ]; then
  source ~/etc/bashrc
fi

EOF
```

```bash
# source ; reload
source ~/etc/bashrc
exec bash
```

## ... behold prompt! `C:\>_`

```
# <env/dir context line(s)>...
# <env/dir context line(s)>...
# marek@NOTEBOOK-YOGA7:/usr/local/sbin
# Wed08 214719 0m4s~ 42 ✗ $
```

```
full:

  # <python environment>
  # <git status>
  # <alert...>
  # <motd...>
  user@hostname : fullpwd
  DayDD HHMMSS LastCommandDuration(approx.) ReturnCode ReturnIcon <$prompt> >>>

```

See [bash_ps1](bash_ps1) for all context features.


## Binaries
> see also bin.git repo

Worthwhile(?) scripts:
* `~/etc/install` - installation script
* `~/etc/sync` - pull submodules recursively


## TODO

* need PowerShell support?!
* add z/OS profile
* add job control info support (`# jobs...`)
* skynet timer on context

* 
