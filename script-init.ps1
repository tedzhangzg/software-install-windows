# script-init.ps1
# ==================================================
# Description
# This script initializes the environment for the SW_Win scripts.
# It downloads necessary script files from GitHub and includes them.
# It also clears the screen and runs the main menu script.
# ==================================================
# Usage
# Use run_as_admin.cmd to run this script with administrative privileges.
# ==================================================


Write-Host "Starting script-init.ps1 ..."

# define ordered hash table of filenames and GitHub links
$odhashtb_filesghlinks = [ordered]@{
    "functions.ps1" = "https://raw.githubusercontent.com/tedzhangzg/software-install-windows/main/functions.ps1"
    "script-mainmenu.ps1" = "https://raw.githubusercontent.com/tedzhangzg/software-install-windows/main/script-mainmenu.ps1"
    "urls.ps1" = "https://raw.githubusercontent.com/tedzhangzg/software-install-windows/main/urls.ps1"
    "values.ps1" = "https://raw.githubusercontent.com/tedzhangzg/software-install-windows/main/values.ps1"
    "script-winget.ps1" = "https://raw.githubusercontent.com/tedzhangzg/software-install-windows/main/script-winget.ps1"
    "script-allapps.ps1" = "https://raw.githubusercontent.com/tedzhangzg/software-install-windows/main/script-allapps.ps1"
    "script-msoffice.ps1" = "https://raw.githubusercontent.com/tedzhangzg/software-install-windows/main/script-msoffice.ps1"
    "script-kms.ps1" = "https://raw.githubusercontent.com/tedzhangzg/software-install-windows/main/script-kms.ps1"
    "script-endusersettings.ps1" = "https://raw.githubusercontent.com/tedzhangzg/software-install-windows/main/script-endusersettings.ps1"
    "script-uninstall.ps1" = "https://raw.githubusercontent.com/tedzhangzg/software-install-windows/main/script-uninstall.ps1"
    "script-createnewuser.ps1" = "https://raw.githubusercontent.com/tedzhangzg/software-install-windows/main/script-createnewuser.ps1"
    "script-msstore.ps1" = "https://raw.githubusercontent.com/tedzhangzg/software-install-windows/main/script-msstore.ps1"
    "script-windowsupdate.ps1" = "https://raw.githubusercontent.com/tedzhangzg/software-install-windows/main/script-windowsupdate.ps1"
}

# loop over all key value pairs
foreach ($key in $odhashtb_filesghlinks.Keys) {
    $ghlink = $($odhashtb_filesghlinks[$key])
    # check, download
    if (-Not (Test-Path -Path "$key")) {
        curl.exe -L -O "$ghlink"
    }
}

# include
. ".\functions.ps1"
. ".\urls.ps1"

# clear screen
Clear-Host

# run main menu script
. ".\script-mainmenu.ps1"

Write-Host ""

Write-Host "Terminating script-init.ps1 ..."
# pause


# ==================================================
# Notes
# ==================================================
