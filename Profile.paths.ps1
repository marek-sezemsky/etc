#Requires -Version 5.1
#
# PS1 PowerPrompt
#
# Add paths
#

### profile.paths()
Write-Host "Add Paths: ~/bin, /c/Utils"

Add-Path -Directory "${env:USERPROFILE}/bin"
Add-Path -Directory 'C:\Utils'
