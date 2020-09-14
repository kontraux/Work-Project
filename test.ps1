if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) { Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs; exit }
# Global Variables
$desktop = ([Environment]::GetEnvironmentVariable("Public"))+"\Desktop"


function Show-Console
{
    param ([Switch]$Show,[Switch]$Hide)
    if (-not ("Console.Window" -as [type])) { 

        Add-Type -Name Window -Namespace Console -MemberDefinition '
        [DllImport("Kernel32.dll")]
        public static extern IntPtr GetConsoleWindow();

        [DllImport("user32.dll")]
        public static extern bool ShowWindow(IntPtr hWnd, Int32 nCmdShow);
        '
    }

    if ($Show)
    {
        $consolePtr = [Console.Window]::GetConsoleWindow()

        $null = [Console.Window]::ShowWindow($consolePtr, 5)
    }

    if ($Hide)
    {
        $consolePtr = [Console.Window]::GetConsoleWindow()
        
        $null = [Console.Window]::ShowWindow($consolePtr, 0)
    }
}


Show-Console -Show

Function Midas_Button_Click()
{
    & $PSScriptRoot\ilead_install\setup.bat
}

Function ITracker_Button_Click()
{
    & $PSScriptRoot\itracker_install\files\setup.exe
}

Function OpenVPN_Button_Click()
{
    & $PSScriptRoot\openvpn_install\openvpn.msi
}

Function Digiticket_Button_Click()
{
    & $PSScriptRoot\digiticket_install\digiticket.msi
}

Function Niche_Button_Click()
{


    Start-Process $PSScriptRoot\niche_install\Redistributables\DhtmlEd.msi /passive -wait
    Start-Process $PSScriptRoot\niche_install\ClientInstaller.msi /passive -wait
    Copy-Item "$PSScriptRoot\niche_install\NicheRMS.lnk" $desktop
    Copy-Item $PSScriptroot\niche_install\niche.ini "C:\Program Files (x86)\Niche\NicheRMS\ClientBin\niche.ini"
    

}

Function Smartforce_Button_Click()
{

    $SourceFileLocation = “https://olathekansas.sharepoint.com/sites/SmartForce/SitePages/Home.aspx”
    $ShortcutLocation = “$Desktop\SmartForce.lnk”
    $WScriptShell = New-Object -ComObject WScript.Shell
    $Shortcut = $WScriptShell.CreateShortcut($ShortcutLocation)
    $Shortcut.IconLocation = "$PSScriptRoot\smartforce_install\smartforce.ico, 0"
    $Shortcut.TargetPath = $SourceFileLocation
    $Shortcut.Save()

}

Function Reader_Button_Click()
{
    Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iwr https://chocolatey.org/install.ps1 -UseBasicParsing | iex | Out-Host
    choco upgrade -y adobereader | Out-Host
}

Function Chrome_Button_Click()
{
    Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iwr https://chocolatey.org/install.ps1 -UseBasicParsing | iex | Out-Host
    choco upgrade google-chrome-for-enterprise -y | Out-Host
}

Function KLite_Button_Click()
{
    Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iwr https://chocolatey.org/install.ps1 -UseBasicParsing | iex | Out-Host
    choco upgrade k-litecodecpackbasic -y | Out-Host
}

Function Dotnet_Button_Click()
{
    Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iwr https://chocolatey.org/install.ps1 -UseBasicParsing | iex | Out-Host
    choco upgrade dotnet3.5 -y | Out-Host
}

Function Office10_Button_Click()
{
    & $PSScriptRoot\Office10_install\Setup.exe /passive -wait | Out-Host
}

Function Office16_Button_Click()
{
    & $PSScriptRoot\Office16_install\Setup.exe /passive -wait | Out-Host
}

Function Zoom_Button_Click()
{
    Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iwr https://chocolatey.org/install.ps1 -UseBasicParsing | iex | Out-Host
    choco upgrade zoom -y | Out-Host
}

Function Defaultapp_Button_Click()
{
    dism /online /Import-DefaultAppAssociations:"$PSScriptRoot\defaultapp_install\DefaultAppAssociations.xml"
    Stop-Process -name explorer -Force
    
}
    
Function Wifi_Button_Click()
{   
    netsh wlan add profile filename="$PSScriptRoot\wifi_fix\Olathe Private Wireless.xml" user=all | Out-Host
    netsh wlan add profile filename="$PSScriptRoot\wifi_fix\Olathe Public Wireless.xml" user=all | Out-Host
    Stop-Process -name explorer -Force
    
}

Function Cred_Button_Click()
{
    cmdkey /list | ForEach-Object{if($_ -like "Target:"){cmdkey /del:($_ -replace " ","" -replace "Target:","")}}
}


Function Generate-Form {

    Add-Type -AssemblyName System.Windows.Forms    
    Add-Type -AssemblyName System.Drawing
    
    # Build Form
    $Form = New-Object System.Windows.Forms.Form
    $Form.Text = "Sam's Very Professional Olathe Installer"
    $Form.Size = New-Object System.Drawing.Size(540,500)
    $Form.StartPosition = "CenterScreen"
    #$Form.Topmost = $True

    # Add Labels
    $Label1 = New-Object System.Windows.Forms.Label 
    $Label1.Text = "Police Software" 
    $Label1.AutoSize = $true 
    $Label1.Location = New-Object System.Drawing.Size(220,15) 
    #$Font = New-Object System.Drawing.Font("Arial",15,[System.Drawing.FontStyle]::Bold) 
    #$form.Font = $Font 
    $Form.Controls.Add($Label1)

    $Label2 = New-Object System.Windows.Forms.Label 
    $Label2.Text = "Other Software" 
    $Label2.AutoSize = $true 
    $Label2.Location = New-Object System.Drawing.Size(220,150) 
    #$Font = New-Object System.Drawing.Font("Arial",15,[System.Drawing.FontStyle]::Bold) 
    #$form.Font = $Font 
    $Form.Controls.Add($Label2)

    $Label3 = New-Object System.Windows.Forms.Label 
    $Label3.Text = "Fixes" 
    $Label3.AutoSize = $true 
    $Label3.Location = New-Object System.Drawing.Size(245,290) 
    #$Font = New-Object System.Drawing.Font("Arial",15,[System.Drawing.FontStyle]::Bold) 
    #$form.Font = $Font 
    $Form.Controls.Add($Label3)

    #LEFT COLUMN

    # Add Midas Button LEFT
    $Midas_Button = New-Object System.Windows.Forms.Button
    $Midas_Button.Location = New-Object System.Drawing.Size(35,35)
    $Midas_Button.Size = New-Object System.Drawing.Size(120,23)
    $Midas_Button.Text = "Midas"

    $Form.Controls.Add($Midas_Button)

    # Add Itracker Button LEFT
    $Itracker_Button = New-Object System.Windows.Forms.Button
    $Itracker_Button.Location = New-Object System.Drawing.Size(35,75)
    $Itracker_Button.Size = New-Object System.Drawing.Size(120,23)
    $Itracker_Button.Text = "ITracker"

    $Form.Controls.Add($Itracker_Button)

    # Add OpenVPN Button LEFT
    $OpenVPN_Button = New-Object System.Windows.Forms.Button
    $OpenVPN_Button.Location = New-Object System.Drawing.Size(35,115)
    $OpenVPN_Button.Size = New-Object System.Drawing.Size(120,23)
    $OpenVPN_Button.Text = "OpenVPN"

    $Form.Controls.Add($OpenVPN_Button)

    # Add Adobe Reader LEFT
    $Reader_Button = New-Object System.Windows.Forms.Button
    $Reader_Button.Location = New-Object System.Drawing.Size(35,175)
    $Reader_Button.Size = New-Object System.Drawing.Size(120,23)
    $Reader_Button.Text = "Adobe Reader"

    $Form.Controls.Add($Reader_Button)

    # Add Button LEFT
    $KLite_Button = New-Object System.Windows.Forms.Button
    $KLite_Button.Location = New-Object System.Drawing.Size(35,215)
    $KLite_Button.Size = New-Object System.Drawing.Size(120,23)
    $KLite_Button.Text = "K-Lite"

    $Form.Controls.Add($KLite_Button)

    # Add Button LEFT
    $Chrome_Button = New-Object System.Windows.Forms.Button
    $Chrome_Button.Location = New-Object System.Drawing.Size(35,255)
    $Chrome_Button.Size = New-Object System.Drawing.Size(120,23)
    $Chrome_Button.Text = "Google Chrome"

    $Form.Controls.Add($Chrome_Button)

    # Add Button LEFT
    $6_Button = New-Object System.Windows.Forms.Button
    $6_Button.Location = New-Object System.Drawing.Size(200,255)
    $6_Button.Size = New-Object System.Drawing.Size(120,23)
    $6_Button.Text = "6"

    $Form.Controls.Add($6_Button)

    # Add Button LEFT
    $Wifi_Button = New-Object System.Windows.Forms.Button
    $Wifi_Button.Location = New-Object System.Drawing.Size(35,315)
    $Wifi_Button.Size = New-Object System.Drawing.Size(120,23)
    $Wifi_Button.Text = "Add Wifi"

    $Form.Controls.Add($Wifi_Button)

    # Add Button LEFT
    $Cred_Button = New-Object System.Windows.Forms.Button
    $Cred_Button.Location = New-Object System.Drawing.Size(35,355)
    $Cred_Button.Size = New-Object System.Drawing.Size(120,23)
    $Cred_Button.Text = "Clear Credentials"

    $Form.Controls.Add($Cred_Button)
    
    #MIDDLE COLUMN


    # Add Digiticket Button
    $Digiticket_Button = New-Object System.Windows.Forms.Button
    $Digiticket_Button.Location = New-Object System.Drawing.Size(200,35)
    $Digiticket_Button.Size = New-Object System.Drawing.Size(120,23)
    $Digiticket_Button.Text = "Digiticket"

    $Form.Controls.Add($Digiticket_Button)

    # Add Niche Button
    $Niche_Button = New-Object System.Windows.Forms.Button
    $Niche_Button.Location = New-Object System.Drawing.Size(200,75)
    $Niche_Button.Size = New-Object System.Drawing.Size(120,23)
    $Niche_Button.Text = "Niche"

    $Form.Controls.Add($Niche_Button)

    # Add Smartforce Button
    $Smartforce_Button = New-Object System.Windows.Forms.Button
    $Smartforce_Button.Location = New-Object System.Drawing.Size(200,115)
    $Smartforce_Button.Size = New-Object System.Drawing.Size(120,23)
    $Smartforce_Button.Text = "Smartforce"

    $Form.Controls.Add($Smartforce_Button)

    # Add Zoom Button
    $Zoom_Button = New-Object System.Windows.Forms.Button
    $Zoom_Button.Location = New-Object System.Drawing.Size(200,175)
    $Zoom_Button.Size = New-Object System.Drawing.Size(120,23)
    $Zoom_Button.Text = "Zoom"

    $Form.Controls.Add($Zoom_Button)

    # Add Skype Button
    $Skype_Button = New-Object System.Windows.Forms.Button
    $Skype_Button.Location = New-Object System.Drawing.Size(200,215)
    $Skype_Button.Size = New-Object System.Drawing.Size(120,23)
    $Skype_Button.Text = "Skype"

    $Form.Controls.Add($Skype_Button)

             # Add Button
    $Defaultapp_Button = New-Object System.Windows.Forms.Button
    $Defaultapp_Button.Location = New-Object System.Drawing.Size(200,315)
    $Defaultapp_Button.Size = New-Object System.Drawing.Size(120,23)
    $Defaultapp_Button.Text = "Fix file associations"

    $Form.Controls.Add($Defaultapp_Button)

                # Add Button
    $13_Button = New-Object System.Windows.Forms.Button
    $13_Button.Location = New-Object System.Drawing.Size(200,355)
    $13_Button.Size = New-Object System.Drawing.Size(120,23)
    $13_Button.Text = "13"

    $Form.Controls.Add($13_Button)



    #RIGHT COLUMN


            # Add MPS Button
    $Mps_Button = New-Object System.Windows.Forms.Button
    $Mps_Button.Location = New-Object System.Drawing.Size(375,35)
    $Mps_Button.Size = New-Object System.Drawing.Size(120,23)
    $Mps_Button.Text = "MPS"

    $Form.Controls.Add($Mps_Button)

            # Add Comodo Button
    $Comodo_Button = New-Object System.Windows.Forms.Button
    $Comodo_Button.Location = New-Object System.Drawing.Size(375,75)
    $Comodo_Button.Size = New-Object System.Drawing.Size(120,23)
    $Comodo_Button.Text = "Comodo"

    $Form.Controls.Add($Comodo_Button)

                # Add Security_Desk Button
    $Security_Desk_Button = New-Object System.Windows.Forms.Button
    $Security_Desk_Button.Location = New-Object System.Drawing.Size(375,115)
    $Security_Desk_Button.Size = New-Object System.Drawing.Size(120,23)
    $Security_Desk_Button.Text = "Security Desk"

    $Form.Controls.Add($Security_Desk_Button)

    # Add Button
    $Office10_Button = New-Object System.Windows.Forms.Button
    $Office10_Button.Location = New-Object System.Drawing.Size(375,175)
    $Office10_Button.Size = New-Object System.Drawing.Size(120,23)
    $Office10_Button.Text = "Office 2010"

    $Form.Controls.Add($Office10_Button)

    # Add Button
    $Office16_Button = New-Object System.Windows.Forms.Button
    $Office16_Button.Location = New-Object System.Drawing.Size(375,215)
    $Office16_Button.Size = New-Object System.Drawing.Size(120,23)
    $Office16_Button.Text = "Office 2016"

    $Form.Controls.Add($Office16_Button)

    # Add Button
    $9_Button = New-Object System.Windows.Forms.Button
    $9_Button.Location = New-Object System.Drawing.Size(375,255)
    $9_Button.Size = New-Object System.Drawing.Size(120,23)
    $9_Button.Text = "9"

    $Form.Controls.Add($9_Button)

              # Add Button
    $Dotnet_Button = New-Object System.Windows.Forms.Button
    $Dotnet_Button.Location = New-Object System.Drawing.Size(375,315)
    $Dotnet_Button.Size = New-Object System.Drawing.Size(120,23)
    $Dotnet_Button.Text = ".NET 3.5"

    $Form.Controls.Add($Dotnet_Button)

                # Add Button
    $15_Button = New-Object System.Windows.Forms.Button
    $15_Button.Location = New-Object System.Drawing.Size(375,355)
    $15_Button.Size = New-Object System.Drawing.Size(120,23)
    $15_Button.Text = "15"

    $Form.Controls.Add($15_Button)


        # Add Done Button
    $Done_Button = New-Object System.Windows.Forms.Button
    $Done_Button.Location = New-Object System.Drawing.Size(200,425)
    $Done_Button.Size = New-Object System.Drawing.Size(120,23)
    $Done_Button.Text = "Done"

    $Form.Controls.Add($Done_Button)

    #Add Button event 
    $Midas_Button.Add_Click({Midas_Button_Click})
    $Itracker_Button.Add_Click({Itracker_Button_Click})
    $OpenVPN_Button.Add_Click({OpenVPN_Button_Click})
    $Digiticket_Button.Add_Click({Digiticket_Button_Click})
    $Wifi_Button.Add_Click({Wifi_Button_Click})
    $Niche_Button.Add_Click({Niche_Button_Click})
    $Smartforce_Button.Add_Click({Smartforce_Button_Click})
    $Reader_Button.Add_Click({Reader_Button_Click})
    $Chrome_Button.Add_Click({Chrome_Button_Click})
    $KLite_Button.Add_Click({KLite_Button_Click})
    $Office10_Button.Add_Click({Office10_Button_Click})
    $Office16_Button.Add_Click({Office16_Button_Click})
    $Dotnet_Button.Add_Click({Dotnet_Button_Click})
    $Defaultapp_Button.Add_Click({Defaultapp_Button_Click})
    $Zoom_Button.Add_Click({Zoom_Button_Click})
    $Skype_Button.Add_Click({Skype_Button_Click})
    $Done_Button.Add_Click({$Form.Close()})
    
    


    #Show the Form 
    $form.ShowDialog()| Out-Null 
 
}  
 

Generate-Form
