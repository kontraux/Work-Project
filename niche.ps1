if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) { Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs; exit }
$desktop = ([Environment]::GetEnvironmentVariable("Public"))+"\Desktop"

Write-Host "Attempting installation..."
Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope CurrentUser

cmd /c \\olatheks.local\Software\Workstation\PD_Software\Niche\Redistributables\DhtmlEd.msi /passive
cmd /c \\olatheks.local\Software\Workstation\PD_Software\Niche\ClientInstaller.msi /passive

Copy-Item \\olatheks.local\Software\Workstation\PD_Software\Niche\NicheRMS.lnk $desktop
#Remove-Item "$desktop\Niche RMS.lnk"
Copy-Item "\\olatheks.local\Software\Workstation\PD_Software\Niche\niche.ini" "C:\Program Files (x86)\Niche\NicheRMS\ClientBin\niche.ini" 


Write-Host "Operation complete!"
pause