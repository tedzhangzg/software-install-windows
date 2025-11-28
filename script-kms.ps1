# script-kms.ps1
# ==================================================
# Description
# This script is used to activate Windows and Office using KMS (Key Management Service) methods.
# It provides options for both online and offline activation methods, including the use of MAS (Microsoft
# Activation Scripts) and KMSAuto Lite.
# It also includes functionality to handle antivirus exclusions and scheduled tasks for automatic activation.
# ==================================================
# Usage
# This script should be run in a PowerShell environment with administrative privileges.
# It will prompt the user to select an activation method and proceed with the necessary steps based on
# the selected option.
# The script will also handle downloading necessary files, extracting them, and executing the activation commands.
# ==================================================


Write-Host "Starting script-kms.ps1 ..."

# include
. ".\functions.ps1"
. ".\urls.ps1"
. ".\values.ps1"

# var
# $var = ""

Write-Host "Running script from get.activated.win ..."
Write-Host ""
Write-Host ""
irm "https://$url_script_shortMAS" | iex
Write-Host ""
Write-Host ""
Write-Host "... Done running script from get.activated.win"

Write-Host ""

Write-Host "Terminating script-kms.ps1 ..."
# pause


# ==================================================
# Notes
# ==================================================
