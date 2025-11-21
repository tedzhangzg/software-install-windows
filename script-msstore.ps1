# script-msstore.ps1
# ==================================================
# Description
# This script installs the Microsoft Store on Windows LTSC.
# It downloads the necessary files, extracts them, and executes the installation.
# It is designed to be run in a PowerShell environment.
# ==================================================
# Usage
# Run this script in a PowerShell terminal with administrative privileges.
# Ensure that the required files and URLs are correctly set up in the included scripts.
# ==================================================


Write-Host "Starting script-msstore.ps1 ..."

# include
. ".\functions.ps1"
. ".\urls.ps1"
. ".\values.ps1"

# var
# $var = ""

Write-Host ""
Write-Host "================================================================================"
Write-Host "Script - Add Microsoft Store (for Windows LTSC)"
Write-Host "================================================================================"
Write-Host ""


Write-Host ""
Write-Host ""


# Microsoft Store

# param
$app_shortname = "Script_AddMSStore"
$dir_installer = $app_shortname
$install_args = ""

# main Install/Download/Execute
# 
# Download
if (-Not (Test-Path -Path $dir_installer)) {
    $url = $url_script_LTSCAddMSStore
    Downloa-Installe $url $dir_installer
}
# 
# Expand
Get-ChildItem -Path $dir_installer -Recurse -Filter *.zip | ForEach-Object { Expand-Archive -Path $_.FullName -DestinationPath $dir_installer -Force }
Get-ChildItem -Path $dir_installer -Recurse -Filter *.zip | ForEach-Object { Remove-Item -Path $_.FullName -Recurse -Force }
# 
# Install
Get-ChildItem -Path $dir_installer -Recurse -Filter *.cmd | ForEach-Object { Start-Process -FilePath $_.FullName -Wait }

Write-Host ""

Write-Host "Terminating script-msstore.ps1 ..."
pause


# ==================================================
# Notes
# ==================================================
