#Requires -Version 5.1

# --- HARDWARE FIX: Disable Saitek Mouse (mouse-minijoystick) altogether to prevent ghost mouse movement ---
Write-Host "Hledám HID SAITEKMOUSE ..."
$saitek = Get-PnpDevice | Where-Object { $_.InstanceId -match "HID\\SAITEKMOUSE" }

if ($saitek) {
    Write-Host "Nalezeno: $($saitek.FriendlyName) ($($saitek.InstanceId))"
    Write-Host $saitek
    if ($saitek.Status -ne 'Disabled') {
        Write-Host "Zařízení není vypnuto - ve stavu $($saitek.Status) - vypínám ..."
        $saitek | Disable-PnpDevice -Confirm:$false -Verbose
    } else {
        Write-Host "Zařízení vypnuté"
    }
} else {
    Write-Warning "Saitek mouse nenalezena (asi není připojen joystick)."
}

