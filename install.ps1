#Requires -Version 5.1


# PSGallery modules to be installed in this order
$modules = @(
    "Microsoft.WinGet.Client",
    "posh-git"
)

$count = $modules.Length
$user = [System.Security.Principal.WindowsIdentity]::GetCurrent().Name
Write-Host "Installing $count PSGallery modules for CurrentUser $user ..."
Write-Host

$startTime = Get-Date

foreach ($module in $modules) {
    Write-Host "Installing: $module"
    try {
        Install-Module -Name $module -Force -Repository PSGallery -Scope CurrentUser -ErrorAction Stop
    } catch {
        Write-Error $_.Exception.Message
        exit 1
    }
    Write-Host "Installed: $module" -ForegroundColor Green
    Write-Host
}

$endTime = Get-Date
$duration = $endTime - $startTime
Write-Host "Successfully installed $count modules in $($duration.TotalSeconds) seconds." -ForegroundColor Green
Write-Host
