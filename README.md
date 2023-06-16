# `~/etc`

>*If you are not me, this is very probably very useless for you. Not your generic 'dotfiles' repository.*

Marek's tailored and cross-platform profile configuration files and interactive power-prompts for:

- Linux `bash` 4.x - Fedora, *EL, *bian, *buntu, Slackware, WSL 
- Windows `PowerShell` 5.x - Win10,11 (experimental)

Bundles Vim configuration (incl [vim-pathogen](https://github.com/tpope/vim-pathogen) plugins) and several other `~/.*rc` files.

## Installation

Clone in the home|profile directory and run install script:

```bash
# go to userprofile
cd ~                    # /home/marek
cd ${env:USERPROFILE}   # C:\Users\marek

# clone (recursive for bundles)
git clone --recursive https://github.com/marek-sezemsky/etc.git

# install suite
etc/install       # bash
etc/install.ps1   # powershell; TODO
```

## Profile activation

Load in the in `~/.bashrc`:

```bash
# `~/.bashrc` - User specific aliases and functions
# ...

if [ -f ~/etc/bashrc ]; then
  source ~/etc/bashrc
fi
```

Load in the `Profile.ps1`:

```bash
# `$PROFILE.CurrentUserCurrentHost` User specific aliases and functions
# ...

if (Test-Path "${env:USERPROFILE}/etc/profile.ps1") {
  . ${env:USERPROFILE}/etc/profile.ps1
}
```

## Scripts

> see also the global [../bin](../bin) git repo

Worthwhile(?) scripts:

- `~/etc/install` - installation script
- `~/etc/sync` - pull submodules recursively

## TODO

- need PowerShell support?!
- add z/OS profiles
- merge job/worker contexts
- skynet timers
