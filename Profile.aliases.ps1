#Requires -Version 5.1
#
# PowerShell profile aliases
#

#
# "se" -- source (Python) environmnt
#
# Interactive function to:
# - source first found Python ["venv", "env"] in current directory
# - patch the powerprompt function back to our version to revert venv's default prompt addition of "(venv)" prefix
#
function se() {
  $tryEnvDirs = @( "venv", "env" )
  $found = 0;
  
  foreach ($dir in $tryEnvDirs ) {
    if ( Test-Path -Path "${dir}\scripts\activate" ) {
      $found = 1;
      Write-Host "Sourcing Python VirtualEnv: ${dir}"
      Write-Host
      .$dir\scripts\activate
      # TODO: observed on some(?) Pythons that venvs still fuck op the propmt with "se"?!
      powerprompt_patch
      break
    } else {
      Write-Warning "Not a Python VirtualEnv in path: ${dir}"
    }
  }
  
  if ( ! $found ) {
    throw "No Python VirtualEnv found, tried: $tryEnvDirs";
  }
}

# misc aliases

function l()  { Get-ChildItem @args }
function ll() { Get-ChildItem @args }

# git aliases; replacing ct=cleartool + mt=multitool; RIP ClearCase, you will be missed

function g()    { & git @args }
# TODO for ps1: see also ~/etc/install for configured git shortcuts; both 's' and 'g s' work
function a()    { & git add  @args }
function ai()   { & git add --interactive  @args }
function au()   { & git add --update @args }
function br()   { & git branch @args }
function ci()   { & git commit --verbose @args }
function co()   { & git checkout @args }
function d()    { & git diff @args }
function dc()   { & git diff --cached @args } # (eclipses /bin/dc: an arbitrary precision calculator)
function gg()   { & git grep -n @args }
function v()    { & git --no-pager log --abbrev --pretty=onelinedate --date=relative --decorate -30 @args }
function vv()   { & git log --abbrev --pretty=onelinedate --date=relative --decorate --graph @args }
function pull() { & git pull @args }
function push() { & git push @args }
function s()    { & git status --short --branch @args }
function show() { & git show @args }

# quick switch-to-current-master
function master() {
  & git checkout master
  if ($?) {
    & git pull --prune 
    if ($?) {
      & git status
    }
  }
}
