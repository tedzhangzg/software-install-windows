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

# powershell execution policy
Get-ExecutionPolicy -List
Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process -Force

# pre-req
Install-PackageProvider -Name NuGet -Force
Install-Module -Name "PSWindowsUpdate" -Force
Import-Module -Name "PSWindowsUpdate" -Force

# list of commands
Get-Command -Module "PSWindowsUpdate"

# get update
Get-WindowsUpdate
Get-WindowsUpdate -UpdateType Driver
# Get-WUHistory

# install
# Install-WindowsUpdate
# Get-WindowsUpdate -IgnoreUserInput -MicrosoftUpdate -ForceDownload -Install -AcceptAll -AutoReboot -Confirm:$false

# install driver only
Install-WindowsUpdate -Install -AcceptAll -UpdateType Driver -MicrosoftUpdate -ForceDownload -ForceInstall -IgnoreReboot -ErrorAction SilentlyContinue
# repeat until no more update

# hide update
# Hide-WindowsUpdate -KBArticleID KB########

Write-Host ""

Write-Host "Terminating script-windowsupdate.ps1 ..."
pause


# ==================================================
# Notes
# ==================================================
