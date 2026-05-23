#Requires -Version 5.1

# windows/kickstart/kickstart.ps1 - The "BEAST-PC" kicker

# # 2. HARDENING: USB Storage Disable (Security first!)
# Write-Host "Zamykám USB Mass Storage..."
# # Nastaví službu USBSTOR na Disabled (4)
# Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\USBSTOR" -Name "Start" -Value 4

# 3. SETTINGS: Developer Mode & Execution Policy
Write-Host "Odemykám Developer Mode..."
# reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\AppModelUnlock" /t REG_DWORD /f /v "AllowDevelopmentWithoutDevLicense" /d "1"
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force

# 4. INSTALL: Git & Winget refresh
Write-Host "Instaluju Git..."
# Winget je ve Win 11 pre-installed, ale někdy potřebuje 'reset' source
winget source reset --force
winget install --id Git.Git -e --source winget --accept-package-agreements --accept-source-agreements --silent

# Reload PATH, aby byl git.exe vidět hned (hack pro aktuální session)
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")

# # 5. CLONE: Dotfiles / Repo
# # $RepoPath = "$env:USERPROFILE\Dev\win-dotfiles" # C:\Users\Marek\Dev\win-dotfiles
# Write-Host "Klonuju tvůj setup do $RepoPath..."

# if (-not (Test-Path $RepoPath)) {
#     New-Item -ItemType Directory -Force -Path $RepoPath | Out-Null
#     # Tady si doplň svoje repo URL
#     git clone https://github.com/TvojeJmeno/win-beast-setup.git $RepoPath
# } else {
#     Write-Host "Repo už existuje, dělám git pull..."
#     Set-Location $RepoPath
#     git pull
# }

# 6. PROFILE LINKING (Sourcing)
# Tohle je to kouzlo. Místo kopírování souborů jen nalinkujeme tvůj profil z repa.
$PsProfilePath = $PROFILE
if (-not (Test-Path $PsProfilePath)) {
    New-Item -Type File -Path $PsProfilePath -Force
}

# Přidá source příkaz do tvého profilu, pokud tam není
$SourceCmd = ". `"$RepoPath\profile.ps1`""
if (-not (Get-Content $PsProfilePath | Select-String -Pattern "win-beast-setup")) {
    Add-Content -Path $PsProfilePath -Value "`n# BEAST-PC Setup Source`n$SourceCmd"
    Write-Host "Profil nalinkován!"
}

# 7. WALLPAPER SETUP (Bonus)
# Předpokládám, že máš wallpaper v repu: \assets\wallpaper.jpg
$WallpaperPath = "$RepoPath\assets\wallpaper.jpg"
if (Test-Path $WallpaperPath) {
    Write-Host "Nastavuju wallpaper..."
    # C# magic pro okamžitou změnu bez restartu
    $code = @'
    using System.Runtime.InteropServices;
    public class Wallpaper {
        [DllImport("user32.dll", CharSet = CharSet.Auto)]
        public static extern int SystemParametersInfo(int uAction, int uParam, string lpvParam, int fuWinIni);
    }
'@
    Add-Type -TypeDefinition $code
    [Wallpaper]::SystemParametersInfo(20, 0, $WallpaperPath, 3)
}

Write-Host "--- DONE. PLEASE LOGOFF AND LOGON TO COMPLETE SETUP. ---" -ForegroundColor Green
Stop-Transcript
