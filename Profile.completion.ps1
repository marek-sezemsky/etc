#Requires -Version 5.1
#
# Profile.completion.ps1
#
# Dynamically load completion for all available utilities.
#

Write-Host "Loading: completions:" -NoNewline

# Dictionary to store commands and their completion scripts
$completions = @{
    "kubectl" = { kubectl completion powershell }
    "oc"      = { oc completion powershell }
    "helm"    = { helm completion powershell }
}

$missing = @()

# Iterate over the dictionary and load completions
foreach ($command in $completions.Keys) {
    Try {
        & ($completions[$command]) | Out-String | Invoke-Expression
        Write-Host " $command" -NoNewline
    }
    Catch [System.Exception] {
        $missing += $command
    }
}
Write-Host # EOL

# Display missing completions if any
if ($missing.Count -gt 0) {
    Write-Warning "Completions failed to load: $($missing -join ' ')"
}

# Cleanup temporary variables
Remove-Variable -Scope Global -ErrorAction SilentlyContinue -Name 'completions'
Remove-Variable -Scope Global -ErrorAction SilentlyContinue -Name 'missing'

