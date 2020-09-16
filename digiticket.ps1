if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) { Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs; exit }
Write-Host "Attempting installation, please wait..."
msiexec.exe /i \\olatheks.local\Software\Workstation\PD_Software\Digiticket\digiticket.msi /passive
Wait-Process msiexec.exe
Write-Host "Operation complete!"
pause