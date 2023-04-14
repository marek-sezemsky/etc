#Require 5.1

# source Python environment and patch the powerprompt function back to our version
function se {
    if ( Test-Path -Path "env\scripts" ) {
        Write-Host "Loading Python from env ..."
        . env\scripts\activate
        powerprompt_patch
    } elseif ( Test-Path -Path "venv\scrits" ) {
        Write-Host "Loading Python from venv ..."
        . venv\scripts\activate
        powerprompt_patch
    } else {
        Write-Warning "No Python virtual env found (env, venv)!"
    }
}

# PS1 PowerPrompt mimics bash_ps1;

function powerprompt {
    # make a room (empty line)
    Write-Host
    
    # --- '# proxy ..."
    if ( $env:ALL_PROXY ) {
        Write-Host -ForegroundColor Gray -NoNewline "# all proxy "
        Write-Host -ForegroundColor Cyan $env:ALL_PROXY
    }

    # --- '# envs ..."
    if ( $env:VIRTUAL_ENV ) {
        Write-Host -NoNewline -ForegroundColor Gray  "# pyvenv "
        Write-Host -ForegroundColor Cyan $env:VIRTUAL_ENV
    }
    
    # [kubectx]
    $K8sContext=$(Get-Content ~/.kube/config | Select-String -Pattern "current-context: (.*)")
    If ($K8sContext) {
        Write-Host -NoNewline -ForegroundColor Gray  "# kubectx "
        $ctx=$K8sContext.Matches[0].Groups[1].Value
        # Set the prompt to include the cluster name
        Write-Host  -ForegroundColor Yellow "$ctx"
    }        
    
    # --- '# git ...'
    # TODO!?
    
    # [user]@[Host] C:\Dir\Subdir
    Write-Host -ForegroundColor Gray -NoNewline "# "
    Write-Host -ForegroundColor Green -NoNewline $env:USERNAME
    Write-Host -ForegroundColor Gray -NoNewline "@"
    Write-Host -ForegroundColor Green -NoNewline $env:COMPUTERNAME
    Write-Host -ForegroundColor Gray -NoNewline " "
    Write-Host $executionContext.SessionState.Path.CurrentLocation

        # TODO!?
    
    # # --- '# time retval \$' # dík Pane Klobouk 🕑
    # # this is poor man's timer
    # local T=${SECONDS}
    # local M=$((T/60%60))
    # local S=$((T%60))
    # SECONDS=0
    # PS1="${PS1}# ${timecolor}$(date +'%a%d %H%M%S')${__c_off} ${M}m${S}s${warningcolor}~${__c_off} "
    # if [ $retval -eq 0 ]; then
    #     PS1="${PS1}${successcolor}$retval ✓ "
    # else
    #     PS1="${PS1}${failurecolor}$retval ✗ "
    # fi
    # PS1="${PS1}${prompt}${__c_off} "

    # ... behold prompt!
    #     C:\>_
    Write-Host -NoNewline "PS$('>' * ($nestedPromptLevel + 1))"

    return " "
}

# function prompt {
#     powerprompt
# }

# patch powerprompt
function powerprompt_patch {
    Write-Host "Patching prompt function."
    copy-item function:powerprompt function:prompt
}


### profile()

# function kubectl_complete()
Write-Host "Loading 'kubectl' completion."
kubectl completion powershell | Out-String | Invoke-Expression

powerprompt_patch


