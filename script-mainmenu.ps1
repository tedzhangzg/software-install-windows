# script-mainmenu.ps1
# ==================================================
# Description
# This script is the main menu for the Windows scripts.
# It allows the user to select different scripts to run.
# ==================================================
# Usage
# Run this script from script-init.ps1 rather than running directly.
# ==================================================


Write-Host "Starting script-mainmenu.ps1 ..."

# include
. ".\functions.ps1"
. ".\urls.ps1"
. ".\values.ps1"

# var
# $var = ""

# function to show the menu
function Show-Menu {
    Write-Host ""
    Write-Host "  ================================================================================"
    Write-Host "                                   Select Script"
    Write-Host "  ================================================================================"
    Write-Host ""
    Write-Host "    1) All apps"
    Write-Host "    2) Edit list of apps for Script1"
    Write-Host ""
    Write-Host "    4) All config"
    Write-Host "    5) Create new admin user"
    Write-Host ""
    Write-Host "    7) KMS"
    Write-Host ""
    Write-Host "    8) Readme"
    Write-Host "    9) Exit"
    Write-Host ""
    Write-Host "    Others"
    Write-Host "    11) Install WinGet"
    Write-Host "    12) Add Microsoft Store (on EnterpriseLTSC and WinServer)"
    # Write-Host "    13) Microsoft Office"
    Write-Host ""
}

# main loop
# shows menu when other scripts are finished
Do {

    # show the menu
    # read input from user
    Show-Menu
    $selection = Read-Host "  Enter number to select an option"

    # do
    Switch ($selection) {
        #
        1 {
            # 1
            Start-Process -FilePath "powershell.exe" -ArgumentList ".\script-allapps.ps1" -Wait
            break
        }
        2 {
            # 2
            Start-Process -FilePath "notepad.exe" -ArgumentList "values.ps1" -Wait
            break
        }
        4 {
            # 4
            Start-Process -FilePath "powershell.exe" -ArgumentList ".\script-endusersettings.ps1" -Wait
            break
        }
        5 {
            # 5
            Start-Process -FilePath "powershell.exe" -ArgumentList ".\script-createnewuser.ps1" -Wait
            break
        }
        7 {
            # 7
            # start of old code
            # Start-Process -FilePath "powershell.exe" -ArgumentList ".\script-kms.ps1" -Wait
            # end of old code
            # 
            # start of new code
            Write-Host ""
            Write-Host "Installing KMS ..."
            try {
                # new
                irm https://get.activated.win | iex
            } catch {
                # old
                irm https://massgrave.dev/get | iex
            }
            # end of new code
            break
        }
        8 {
            # 8
            # Start-Process -FilePath "powershell.exe" -ArgumentList ".\script-readme.ps1" -Wait
            break
        }
        # 9 {
            # 9
            # exit
            # break
        # }
        11 {
            # 11
            Start-Process -FilePath "powershell.exe" -ArgumentList ".\script-winget.ps1" -Wait
            break
        }
        12 {
            # 12
            Start-Process -FilePath "powershell.exe" -ArgumentList ".\script-msstore.ps1" -Wait
            break
        }
        13 {
            # 13
            Start-Process -FilePath "powershell.exe" -ArgumentList ".\script-msoffice.ps1" -Wait
            break
        }
        default {
            # default
            Write-Host ""
            # break
        }
    }

    # clear screen
    Clear-Host

} Until ($selection -eq 9)

Write-Host ""

Write-Host "Terminating script-mainmenu.ps1 ..."
pause


# ==================================================
# Notes
# ==================================================
