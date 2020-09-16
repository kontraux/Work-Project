    if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) { Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs; exit }
    Write-Host "Attempting installation..."
    netsh wlan add profile filename="\\olatheks.local\Software\Workstation\Private Wireless Setup\Olathe Private Wireless.xml" user=all | Out-Host
    netsh wlan add profile filename="\\olatheks.local\Software\Workstation\Private Wireless Setup\Olathe Public Wireless.xml" user=all | Out-Host
    Stop-Process -name explorer -Force
    Write-Host "Operation complete!"
    pause