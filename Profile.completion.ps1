#Requires -Version 5.1
#
# PS1 PowerPrompt
#
# Completion (for all available utilities)
#

### profile.completion()
Write-Host "Loading completions"

# function kubectl_complete()
Try {
    & kubectl completion powershell | Out-String | Invoke-Expression
} 
Catch [System.Exception] { 
    Write-Warning "No kubectl.exe completion available"
}

# function oc_complete()
Try {
    & oc completion powershell | Out-String | Invoke-Expression
} 
Catch [System.Exception] { 
    Write-Warning "No oc.exe completion available"
}

# load helm completion
Try {
    & helm completion powershell | Out-String | Invoke-Expression
}
Catch [System.Exception] {
    Write-Warning "No helm.exe completion available"
}

