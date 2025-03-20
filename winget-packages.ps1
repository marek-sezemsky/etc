#Requires -Version 5.1
#
# <-List|-Update|-Install> [-All] [package1 package2 ...]
#
# Will operate over winget-packages.txt file in the same directory.
# If no command is given, default is -List.
#
# ChangeLog:
# 2021-09-30: Initial version
#

[CmdletBinding()]
param (
    # commands
    [Parameter()]
    [switch]$Install,
    [Parameter()]
    [switch]$Update,
    [Parameter()]
    [switch]$List,

    # switches
    [Parameter()]
    [switch]$All,
    [Parameter()]
    [switch]$DryRun,

    # packages (any remaining)
    [Parameter(ValueFromRemainingArguments = $true)]
    [string[]]$Packages
)

function Install-Package {
    param (
        [string]$package
    )
    Write-Host "Installing: $package" -ForegroundColor Yellow
    if ($DryRun) {
        Write-Host "DryRun: would install $package" -ForegroundColor Magenta
        return
    }

    & winget install --exact --id $package --accept-package-agreements --accept-source-agreements --source winget
    if (!$?) {
        Write-Error "Failed to install: $package"
        exit 1
    }

    Write-Host "Installed: $package" -ForegroundColor Green
}

function Update-Package {
    param (
        [string]$package
    )
    Write-Host "Updating: $package" -ForegroundColor Yellow
    if ($DryRun) {
        Write-Host "DryRun: would update $package" -ForegroundColor Magenta
        return
    }

    & winget update --exact --id $package --accept-package-agreements --accept-source-agreements --source winget
    if (!$?) {
        Write-Error "Failed to update: $package"
        exit 1
    }

    Write-Host "Updated: $package" -ForegroundColor Green
}

function Write-Package-Item {
    # list package summary of already installed package
    # absent: flag denotes only { .Id } may be available and printout to specify "package absent"
    param (
        [object]$packageObject,
        [switch]$absent
    )

    if ($absent) {
        Write-Warning "Package not installed: $($packageObject.Id)"
        return
    }

    # but messy, but we want to print out the packageObject in a nice way
    Write-Host "Installed:"  -NoNewline
    Write-Host "" $packageObject.Id -ForegroundColor White -NoNewline
    Write-Host "" "($($packageObject.InstalledVersion)" -NoNewline
    if ($packageObject.IsUpdateAvailable) {
        Write-Host "" "==>" $packageObject.AvailableVersions[0] -ForegroundColor Yellow -NoNewline
    }
    Write-Host ")"
}

#
# main()
#

# Parse arguments

$commands = @($Install, $Update, $List)
$trueCount = ($commands | Where-Object { $_ -eq $true }).Count
if ($trueCount -eq 0) {
    # list is default command
    Write-Warning "No command given. Defaulting to -List."
    $List = $true
}
elseif ($trueCount -ne 1) {
    Write-Error "Only one of -Install|-Update|-List allowed."
    exit 1
}
else {
    # one command selected
}

if ($All -and $Packages.Length -gt 0) {
    Write-Error "Can not have -All with package(s) specified."
    exit 1
}

if ($List -and !$All -and $Packages.Length -eq 0) {
    Write-Warning "Defaulting to -All: no packages specified for -List"
    $All = $true
}

if ($List -and $DryRun) {
    Write-Warning "Ignoring -DryRun for -List: makes no sense"
}
if (($Install -or $Update) -and (!$All -and $Packages.Length -eq 0)) {
    Write-Error "Don't know what to do: -Install and -Update need -All or package(s)"
    exit 1
}

# Check for admin rights
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Error "User scoped installations not supported: you should run this script as an Administrator"
    exit 1
}

$installed = @()
# Fetch snapshot of Id of installed packages
try {
    $installedPackagesObjects = Get-WinGetPackage -Source winget
    # .InstalledVersion  : 2.46.0
    # .Name              : Git
    # .Id                : Git.Git
    # .IsUpdateAvailable : True
    # .Source            : winget
    # .AvailableVersions : {2.49.0, 2.48.1, 2.47.1.2, 2.47.1...}

    $installedPackages = @{}
    foreach ($package in $installedPackagesObjects) {
        $installedPackages[$package.Id] = $package
        $installed += $package.Id
    }
} catch {
    Write-Error "Failed to get installed packages using Get-WinGetPackage."
    exit 1
}
Write-Host "Packages currently installed: $($installed.Length)"

# Read package file list
$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$packageFile = Join-Path $scriptDir "winget-packages.txt"
$lines = Get-Content -Path $packageFile
$packagesInFile = ($lines | Where-Object { $_ -notmatch '^\s*$' -and $_ -notmatch '^#' })
$packageCount = $packagesInFile.Length
Write-Host "Packages in list file: $packageCount @ $packageFile"
# (no Write-Host empty separator here, first group printout will give us spacer)

# final check, make sure user did not do a typo;
# all argument packages must be in the packages file
if ($Packages.Length -gt 0) {
    $bailOut = $false
    foreach ($package in $Packages) {
        if ($packagesInFile -notcontains $package) {
            Write-Error "Package not in list file: $package"
            $bailOut = $true
        }
    }
    if ($bailOut) {
        exit 1
    }
}

$startTime = Get-Date
$group = ""
$skipped = @()

# Package file is our driver here:
# we manipulate on groups of packages given to us in winget-packages.txt ($requiredPackages)

foreach ($line in $lines) {
    $package, $version = "", ""
    if ($line.StartsWith('##') -or ($line -match '^\s*$')) {
        # skip comments and empty lines
        continue
    }
    elseif ($line.StartsWith('# ')) {
        $group = $line.TrimStart('# ')
        Write-Host
        Write-Host "Group: $group" -ForegroundColor Cyan
        continue
    }
    else {
        # consider any other line as a package
        $package = $line.Trim()

        # skip not listed package if package is in the list of specified packages
        if ($Packages.Length -gt 0) {
            if ($Packages -notcontains $package) {
                Write-Host "Skipping: $package" -ForegroundColor DarkGray
                $skipped += $package
                continue
            }
        }

        $isInstalled = $installed -contains $package
        $needsUpdate = $isInstalled -and $installedPackages[$package].IsUpdateAvailable

        if ($Install) {
            if (!$isInstalled) {
                Install-Package $package
            }
            else {
                Write-Package-Item $installedPackages[$package]
            }
        }
        elseif ($Update) {
            if ($isInstalled) {
                if ($needsUpdate) {
                    Update-Package $package
                } else {
                    Write-Package-Item $installedPackages[$package]
                }
            }
            else {
                Write-Package-Item  -absent @{ Id = $package }
            }
        }
        elseif ($List) {
            if ($isInstalled) {
                Write-Package-Item $installedPackages[$package]
            }
            else {
                Write-Package-Item  -absent @{ Id = $package }
            }
        }
        else {
            throw "lolwut"
        }
    }
}

$endTime = Get-Date
$duration = ($endTime - $startTime).TotalSeconds / 60
Write-Host
Write-Host "Done in $duration minutes."
Write-Host
