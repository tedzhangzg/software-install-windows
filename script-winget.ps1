# script-winget.ps1
# ==================================================
# Description
# This script checks for the installation of WinGet
# and installs it if not present. It also installs
# necessary prerequisites such as the C++ Desktop
# Bridge and NuGet packages.
# ==================================================
# Usage
# Run this script in a PowerShell environment with
# administrative privileges to ensure proper installation
# of WinGet and its dependencies.
# ==================================================


Write-Host "Starting script-winget.ps1 ..."

# include
. ".\functions.ps1"
. ".\urls.ps1"
. ".\values.ps1"

# var
# $var = ""

# Change Colours
Clear-Host
$host.UI.RawUI.BackgroundColor = "DarkGreen"
# $host.UI.RawUI.ForegroundColor = "DarkYellow"
Clear-Host

Write-Host "Running script from winget.pro ..."
Write-Host ""
Write-Host ""
irm $url_script_WinGetInstall | iex
Write-Host ""
Write-Host ""
Write-Host "... Done running script from winget.pro"

Write-Host ""

Write-Host "Terminating script-winget.ps1 ..."
# pause


# ==================================================
# Notes
# ==================================================
