if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) { Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs; exit }
Write-Host "Attempting installation..."
cmd /c \\olatheks.local\software\Workstation\PD_Software\ITracker\setup.exe /S /v /qn
Write-Host "Operation complete!"
Pause