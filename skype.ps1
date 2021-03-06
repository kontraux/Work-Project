﻿    Write-Host "Attempting installation..."
    Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iwr https://chocolatey.org/install.ps1 -UseBasicParsing | iex | Out-Host
    choco upgrade skype -y | Out-Host
    Write-Host "Operation complete!"
    pause