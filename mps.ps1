if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) { Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs; exit }
cmd /c mklink /D c:\Netstore '\\olatheks.local\Software\Workstation\PD_Software\MPS 9.3 Installation\' | Out-Host
Start-Process 'c:\Netstore\1IPS1183-RemoteContentManagement\mps1.exe' -wait | Out-Host
Start-Process 'c:\Netstore\2IPS0080-MobilePublicSafety\mps2.exe' -wait | Out-Host
Start-Process 'c:\Netstore\3Informer930_MR5\mps3.exe' | Out-Host
cmd /c rmdir c:\Netstore
Write-Host "Operation has completed."
pause