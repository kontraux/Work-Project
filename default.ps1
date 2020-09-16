    if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) { Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs; exit }
    Write-Host "Attempting installation..."
    dism /online /Import-DefaultAppAssociations:"\\olatheks.local\Software\Workstation\Default App Associations\DefaultAppAssociations.xml"
    Stop-Process -name explorer -Force
    Write-Host "Operation complete!"
    pause