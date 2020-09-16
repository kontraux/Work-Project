    if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) { Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs; exit }
    Write-Host "Attempting operation..."
    cmdkey /list | ForEach-Object{if($_ -like "Target:"){cmdkey /del:($_ -replace " ","" -replace "Target:","")}}
    Write-Host "Operation complete!"
    pause