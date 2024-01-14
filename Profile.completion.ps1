#Requires -Version 5.1
#
# PS1 PowerPrompt
#
# Completion (for all available utilities)
#

### profile.completion()
Write-Host "Loading completions"

# function kubectl_complete()
& kubectl completion powershell | Out-String | Invoke-Expression

# load helm completion
& helm completion powershell | Out-String | Invoke-Expression
