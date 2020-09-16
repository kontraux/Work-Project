    if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) { Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs; exit }
    $desktop = ([Environment]::GetEnvironmentVariable("Public"))+"\Desktop"
    Write-Host "Attempting installation, please wait..."
    $SourceFileLocation = “https://olathekansas.sharepoint.com/sites/SmartForce/SitePages/Home.aspx”
    $ShortcutLocation = “$Desktop\SmartForce.lnk”
    $WScriptShell = New-Object -ComObject WScript.Shell
    $Shortcut = $WScriptShell.CreateShortcut($ShortcutLocation)
    $Shortcut.IconLocation = "\\olatheks.local\Software\Workstation\PD_Software\Smartforce\smartforce.ico, 0"
    $Shortcut.TargetPath = $SourceFileLocation
    $Shortcut.Save()
    Write-Host "Operation complete!"
    pause