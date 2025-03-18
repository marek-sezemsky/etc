#Requires -Version 5.1

Set-Location (split-path $MyInvocation.MyCommand.Path -Parent) 

$installed = Get-WinGetPackage -Source winget

foreach ($package in $installed) {
    Write-Host $package.Id $package.Name
}
