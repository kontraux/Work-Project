if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) { Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs; exit }
cmd /c mklink /D c:\Netstore '\\olatheks.local\Software\Workstation\PD_Software\Open VPN\' | Out-Host
cmd /c c:\netstore\setup.exe /S
cmd /c rmdir c:\Netstore
Write-Host "Operation has completed."
pause
