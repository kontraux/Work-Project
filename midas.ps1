if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) { Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs; exit }
Write-Host "Attempting to install..."
cmd /c \\olatheks.local\Software\Workstation\PD_Software\ilead_install\setup.bat
Write-Host "Operation has completed!"