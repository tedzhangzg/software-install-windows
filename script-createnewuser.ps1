# script-createnewuser.ps1
# ==================================================
# Description
# This script creates a new local user account on the system.
# It prompts for the account name and whether to make it an administrator.
# The script sets the account to never expire and requires a password.
# ==================================================
# Usage
# Run this script in PowerShell with administrative privileges.
# ==================================================


Write-Host "Starting script-createnewuser.ps1 ..."

# include
. ".\functions.ps1"
. ".\urls.ps1"
. ".\values.ps1"

# var
# $var = ""

Write-Host ""
Write-Host "================================================================================"
Write-Host "Script - Create new user"
Write-Host "================================================================================"
Write-Host ""

# ask
$new_acc_name = Read-Host -Prompt "Enter word (no space) - Account name (if blank then defaults to IT): "
# Defaults to ITSupport
if ($new_acc_name -eq "") {
    # Defaults to ITSupport
	$new_acc_name = "IT"
}

Write-Host "Creating account ..."
New-LocalUser -Name $new_acc_name | Out-Null

Write-Host "Account PasswordNeverExpires ..."
Set-LocalUser -Name $new_acc_name -PasswordNeverExpires $true
# cmd (archive)
# wmic UserAccount where Name='ITSupport' set PasswordExpires=False

Write-Host "Account PasswordRequired ..."
Invoke-Expression ("Get-WmiObject Win32_UserAccount -Filter 'Name = `"" + $new_acc_name + "`"' | Set-WmiInstance -Arguments @{PasswordRequired=`$true} | Out-Null")
# Get-WmiObject Win32_UserAccount -Filter 'Name = "ITSupport"' | Set-WmiInstance -Arguments @{PasswordRequired=$true} | Out-Null

Write-Host "Account AddTo Users ..."
Add-LocalGroupMember -Group "Users" -Member $new_acc_name

# make admin
while ($make_account_admin -notin @("y","n")) {
    $make_account_admin = (Read-Host -Prompt "Enter letter - Make account admin: y , n ").ToLower()
}
if ($make_account_admin -eq "y") {
    Write-Host "Account AddTo Administrators ..."
    Add-LocalGroupMember -Group "Administrators" -Member $new_acc_name
}
# cmd (archive)
# net localgroup administrators ITSupport /add

Write-Host "Edit Accounts ..."
Show-ControlPanelItem -CanonicalName "Microsoft.UserAccounts"

Write-Host ""

# final

Clear-PSHistory

Write-Host ""

Write-Host "Terminating script-createnewuser.ps1 ..."
pause


# ==================================================
# Notes
# ==================================================
