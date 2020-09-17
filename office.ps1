if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) { Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs; exit }
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iwr https://chocolatey.org/install.ps1 -UseBasicParsing | iex | Out-Host
Write-Host "Attempting installation..."
cmd /c \\olatheks.local\Software\Workstation\Microsoft\Office 2016 Applications\Setup.X64.en-us_O365ProPlusRetail_0f4da291-4cb6-428e-aee7-d5720c0644bd_TX_PR_b_64_.exe /passive -wait | Out-Host
Write-Host "Operation complete!"
Pause