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


# Create temp folder
$tmp_dir = "$env:TEMP\tempappdlinst"
Creat-NewEmpty-Folde $tmp_dir


Write-Host ""
Write-Host ""


# Microsoft Store

# Param
$dir_installer = "AddMSStore"
$install_args = ""
# Install/Download/Execute
# Download
if (-Not (Test-Path -Path $dir_installer)) {
    $url = $url_addmsstore
    Downloa-Installe $url $dir_installer
}

# Expand
Get-ChildItem -Path $dir_installer -Recurse -Filter *.zip | ForEach-Object { Expand-Archive -Path $_.FullName -DestinationPath $dir_installer -Force }
Get-ChildItem -Path $dir_installer -Recurse -Filter *.zip | ForEach-Object { Remove-Item -Path $_.FullName -Recurse -Force }

# Install
# Only the C++ Runtime Desktop Bridge
# Get-ChildItem -Path $dir_installer -Recurse -Filter "*vclibs*" | ForEach-Object { Add-AppxPackage -Path $_.FullName }
# Full Microsoft Store
Get-ChildItem -Path $dir_installer -Recurse -Filter *.cmd | ForEach-Object { Start-Process -FilePath $_.FullName -Wait }


Write-Host ""

# final

Clear-PSHistory

Write-Host ""

Write-Host "Terminating script-msstore.ps1 ..."
pause


# ==================================================
# Notes
# ==================================================
