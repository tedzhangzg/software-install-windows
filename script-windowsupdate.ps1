# script-windowsupdate.ps1
# ==================================================
# Description
# This script is used to manage Windows Updates on a Windows system.
# It includes functions to check for updates, install them, and manage update history.
# ==================================================
# Usage
# This script should be run with administrative privileges.
# Ensure that the PowerShell execution policy allows script execution.
# ==================================================


Write-Host "Starting script-windowsupdate.ps1 ..."

# include
. ".\functions.ps1"
. ".\urls.ps1"
. ".\values.ps1"

# var
# $var = ""

Write-Host ""
Write-Host "================================================================================"
Write-Host "Script - Windows Update"
Write-Host "================================================================================"
Write-Host ""

# prep ps env
Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process -Force
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
# do every time script is called

# install pre-req
Install-PackageProvider -Name NuGet -Force
Install-Module -Name PackageManagement -AllowClobber -Force
Install-Module -Name PowerShellGet -AllowClobber -Force

# install mod
Install-Module -Name PSWindowsUpdate -AllowClobber -Force

# get commands
Get-Command -Module PSWindowsUpdate

# get updates
Get-WindowsUpdate
Get-WindowsUpdate -UpdateType Driver
Get-WindowsUpdate -IsHidden

# install updates
Install-WindowsUpdate
Install-WindowsUpdate -AcceptAll -AutoReboot
Get-WindowsUpdate -AcceptAll -Install -AutoReboot
Install-WindowsUpdate -UpdateType Driver -AcceptAll -AutoReboot
Install-WindowsUpdate -KBArticleID KB1234567 -AcceptAll -AutoReboot
Install-WindowsUpdate -KBArticleID KB5010793,KB5009566 -AcceptAll -AutoReboot

# hide updates
# Hide-WindowsUpdate -KBArticleID KB1234567 -Hide -Confirm:$false
# UnHide-WindowsUpdate -KBArticleID KB1234567 -Confirm:$false

# get history
Get-WUHistory

# check reboot
Get-WURebootStatus


Write-Host ""

Write-Host "Terminating script-windowsupdate.ps1 ..."
pause


# ==================================================
# Notes
# ==================================================
