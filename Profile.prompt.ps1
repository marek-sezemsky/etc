#Requires -Version 5.1
#
# PS1 PowerPrompt
#
# Windows (lite) version of bash_ps1;
#
Write-Host "Defining powerprompt (with 'posh-git' module)"
Import-Module posh-git

# check if current user is admin
function is_admin() {
  $user = [Security.Principal.WindowsIdentity]::GetCurrent();
  (New-Object Security.Principal.WindowsPrincipal $user).IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator) 
}

function powerprompt {
  # remember status of just finished command
  $__prev=$?
  
  # make a room since last printout (empty line)
  Write-Host
  
  # --- # admin!
  if ( is_admin ) {
    Write-Host -ForegroundColor DarkGray -NoNewline "# "
    Write-Host -ForegroundColor DarkRed "Administrator"
  }
  
  # --- '# proxy ..."
  if ( $env:ALL_PROXY ) {
    Write-Host -ForegroundColor DarkGray -NoNewline "# "
    Write-Host -ForegroundColor Cyan -NoNewline "webproxy "
    Write-Host -ForegroundColor Magenta "${env:ALL_PROXY}"
  }
  
  # --- '# Python venvs ..."
  if ( $env:VIRTUAL_ENV ) {
    Write-Host -NoNewline -ForegroundColor Gray  "# "
    Write-Host -NoNewline -ForegroundColor Yellow "Python venv "
    Write-Host -ForegroundColor Cyan $env:VIRTUAL_ENV
  }

  # --- '# k8s KUBECONFIG  ..."
  if ( $env:KUBECONFIG ) {
    Write-Host -ForegroundColor DarkGray -NoNewline "# "
    Write-Host -ForegroundColor LightBlue -NoNewline "k8s "
    Write-Host -ForegroundColor Gray -NoNewline "KUBECONFIG "
    Write-Host -ForegroundColor Blue $env:KUBECONFIG 
  }

  # --- '# k8s ns ... ctx ... (admin)"
  $kubectx=$(kubectx --current 2>$null)
  If ($kubectx) {
    $kubens=$(kubens --current 2>$null)
    Write-Host -ForegroundColor DarkGray -NoNewline "# "
    Write-Host -ForegroundColor Blue -NoNewline "k8s "
    Write-Host -ForegroundColor Gray -NoNewline "ns "
    Write-Host -ForegroundColor Yellow -NoNewline $kubens
    Write-Host -ForegroundColor Gray -NoNewline " ctx "
    Write-Host -ForegroundColor Yellow -NoNewline $kubectx

    if ( ($kubectx -imatch "admin") -Or ($kubens -imatch "kube-") ) {
      Write-Host -ForegroundColor Red -NoNewline " Administrator"
    }
    Write-Host 
  }

  # --- '# git <(__git_ps1) # (commit msg)...'
  # TODO!? gitposh
  if ($status = Get-GitStatus -Force) {
    # Write-Host $status
    Write-Host -ForegroundColor DarkGray -NoNewline "# "
    Write-Host -ForegroundColor DarkRed -NoNewline "git"
    if ($status) {
      # sha1
      $hash = $( git rev-parse --short HEAD )
      if ( $hash ) {
        Write-Host -ForegroundColor DarkCyan -NoNewline " $hash"
      }
      # branch
      $branch = $status.Branch;
      if ( $branch ) {
        Write-Host -ForegroundColor DarkYellow -NoNewline " ${branch}";
      }
      # $gitstr += $(Write-GitWorkingDirStatus $status)
      # '*' Working, '+' Index, '%' untracked
      $gitstr = ""
      if ( $status.HasWorking )   { $gitstr += "*" }
      if ( $status.HasIndex )     { $gitstr += "+" }
      if ( $status.HasUntracked ) { $gitstr += "%" }
      if ( $gitstr ) {
        Write-Host -ForegroundColor DarkYellow -NoNewline " ${gitstr}"
      }
      
      # upstream
      $upstream = $status.Upstream;
      if ( $upstream ) {
        $ahead = $status.AheadBy;
        $behind = $status.BehindBy;
        $u = "u"
        if ( ($behind -Eq "0") -And ($ahead -Eq "0") ) {
          $u += "="
        }
        if ( !($behind -Eq "0") ) {
          $u += "-${behind}"
        }
        if ( !($ahead -Eq "0") ) {
          $u += "+${ahead}"
        }
        Write-Host -ForegroundColor DarkYellow -NoNewline " ${u}"
      }

      # normalized git commit message
      $gitmsg = "$(git --no-pager log -1 --format=format:'%f')"
      if ($gitmsg ) {
        Write-Host -ForegroundColor DarkGray -NoNewline " ${gitmsg}"
      }
      
      # CRLF
      Write-Host 
    }
  
  }

  # [user]@[Host] C:\Dir\Subdir
  Write-Host -ForegroundColor DarkGray -NoNewline "# "
  Write-Host -ForegroundColor Green -NoNewline $env:USERNAME
  Write-Host -ForegroundColor DarkGray -NoNewline "@"
  Write-Host -ForegroundColor Green -NoNewline $env:COMPUTERNAME
  Write-Host -ForegroundColor DarkGray -NoNewline " "
  Write-Host $executionContext.SessionState.Path.CurrentLocation
  
  # TODO!?
  
  # timestamp
  Write-Host -ForegroundColor DarkGray -NoNewline "# $(Get-Date -Format "ddd.dd HH:mm:ss") "


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
  $ps = "PS$('>' * ($nestedPromptLevel + 1))"
  if ( $__prev ) {
    Write-Host -NoNewline -ForegroundColor Green "."
    Write-Host -NoNewline " $ps"
  } else {
    Write-Host -NoNewline -ForegroundColor Red "X $ps"
  }

  # --- '# versions' for DEBUG
  return " "
}

# patch powerprompt
function powerprompt_patch {
  copy-item function:powerprompt function:prompt
}


# introduce our power prompt
powerprompt_patch

