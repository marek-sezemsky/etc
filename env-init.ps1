#Requires -Version 5.1

$venv = "venv"

Set-Location (split-path $MyInvocation.MyCommand.Path -Parent) 

function run_check($cmd) {
    Write-Host "&&& $cmd"
    & $cmd
    if (!$?) {
        throw "Command failed: $cmd"
    }
}

run_check({ python3 -m venv $venv })

Write-Host "... $venv/scripts/activate.ps1"
. ./$venv/scripts/activate.ps1
if (!$?) {
    throw "Failed to source environment!"
}

run_check({ python -m pip install --upgrade pip })
run_check({ python -m pip install -r requirements.txt })
run_check({ python -m pip list })

Write-Host ""
Write-Host "Done."
Write-Host ""
