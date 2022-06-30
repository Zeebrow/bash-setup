function Pro {notepad $PROFILE.CurrentUserAllHosts}
set-alias cat write-host
set-alias vim notepad
set-alias bash PowerShell
set-alias function Pro {notepad $PROFILE.CurrentUserAllHosts}
set-alias cat write-host
set-alias vim notepad
set-alias bash PowerShell
set-alias gco 'git checkout'
set-alias glo 'git log --oneline'
set-alias gs 'git status'
function Prompt
{
$env:COMPUTERNAME + "\" + (Get-Location) + "> "
}



#https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_profiles?view=powershell-7.2


function Prompt
{
$env:COMPUTERNAME + "\" + (Get-Location) + "> "
}



#https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_profiles?view=powershell-7.2

