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

Write-Host ""
Write-Host "================================================================================"
Write-Host "Script - KMS"
Write-Host "================================================================================"
Write-Host ""

# Constants
$dir_extractedfile_kms = "$env:APPDATA\KMS"
$dir_origfile_onlinekms = "KMS\1"
$dir_origfile_offlinekms = "KMS\2"

# Create folders
Creat-NewEmpty-Folde $dir_extractedfile_kms


# WinGet
try {
    # Check
    winget search --id "Google.Chrome" --accept-source-agreements
} catch {
    # Install manually
    Write-Host "Looks like WinGet is not installed"
    Write-Host "You might need to install winget, for script to install 7-zip automatically."
}

Write-Host ""

# list
Write-Host ""
Write-Host ""
Write-Host ""
Write-Host "##################################################"
Write-Host "What would you like to do?"
Write-Host "##################################################"
Write-Host "1) Activate Manually with MAS Online (for advanced options or earlier failed attempts)"
Write-Host ""
Write-Host "2) Activate Office with MAS ohook (recommended)"
Write-Host "3) Activate Office with MAS KMS"
Write-Host ""
Write-Host "4) Activate Windows with MAS HWID (recommended)"
Write-Host "5) Activate Windows with MAS KMS38"
Write-Host "6) Activate Windows with MAS KMS (not recommended)"
# include offline activation option if file exist
if (Test-Path -Path $dir_origfile_offlinekms) {
    Write-Host ""
    Write-Host ""
    Write-Host "7) Activate Manually with KMSAutoLite Offline (not recommended)"
    Write-Host ""
    Write-Host "8) Activate Office with KMSAutoLite (not recommended)"
    Write-Host "9) Activate Windows with KMSAutoLite (not recommended)"
}
Write-Host "##################################################"
Write-Host ""
Write-Host ""

# ask
if (Test-Path -Path $dir_origfile_offlinekms) {
    # check if input is from 1 to 9
    while ($activation_method -notin 1..9) {
        [int]$activation_method = Read-Host -Prompt "Enter number"
    }
} else {
    # check if input is from 1 to 6
    while ($activation_method -notin 1..6) {
        [int]$activation_method = Read-Host -Prompt "Enter number"
    }
}

# Add to Defender exclusion
Add-MpPreference -ExclusionPath $dir_extractedfile_kms

# Download/Prepare KMS file
if ((1 -le $activation_method) -and ($activation_method -le 6)) {
    # Option 1
    # check if folder exist (assume file exist when folder exist)
    if (-Not(Test-Path -Path $dir_origfile_onlinekms)) {
        # actual download
        Downloa-Installe "$url_MAS_githubraw" "$dir_origfile_onlinekms"
    }
    # Copy
    Get-ChildItem -Path $dir_origfile_onlinekms -Recurse -Filter *.cmd | ForEach-Object { Copy-Item -Path $_.FullName -Destination $dir_extractedfile_kms -Recurse }
    # Done
} elseif ((7 -le $activation_method) -and ($activation_method -le 9)) {
    # Option 2
    # Constants
    $filename_origfile_offlinekms = Get-ChildItem -Path $dir_origfile_offlinekms -Name
    $file_origfile_offlinekms_pw2unzip = (Get-ChildItem -Path $dir_origfile_offlinekms).Basename
    # Add to PATH
    if (-Not (Test-Path -Path "$env:ProgramFiles\7-Zip")) {
        winget install --id "7zip.7zip"
    }
    $env:Path += ";$env:ProgramFiles\7-Zip"
    # Note: For WinRAR
    # if (-Not (Test-Path -Path "$env:ProgramFiles\WinRAR")) {
        # winget install --id "RARLab.WinRAR"
    # }
    # $env:Path += ";$env:ProgramFiles\WinRAR"
    # Extract file
    7z e "$dir_origfile_offlinekms\$filename_origfile_offlinekms" -o"$dir_extractedfile_kms" -p"$file_origfile_offlinekms_pw2unzip"
    # for WinRAR
    # unrar x "$dir_origfile_offlinekms\$filename_origfile_offlinekms" $dir_extractedfile_kms -p"$file_origfile_offlinekms_pw2unzip"
    # Done
} else {
    # otherwise
    Write-Host "Quit and Manually activate"
    pause
    exit
}

Write-Host ""
Write-Host ""

# Instructions
Write-Host ""
Write-Host "##################################################"
Write-Host "Do now (if applicable):"
Write-Host "##################################################"
Write-Host ""
Write-Host "Manually resolve any antivirus issues blocking execution, for eg, add to exception, allow execution, etc"
Write-Host ""
Write-Host "##################################################"
Write-Host ""
Write-Host ""
Write-Host ""
Write-Host ""
Write-Host ""
Write-Host "##################################################"
Write-Host "STEPS - FOLLOW"
Write-Host "##################################################"
Write-Host ""
switch ($activation_method) {
    1 {
        # 1
        Write-Host "Manual ..."
        break
    }
    2 {
        # 2
        Write-Host "Option 2: Ohook"
        Write-Host "Option 1: Install Ohook Office Activation"
        break
    }
    3 {
        # 3
        Write-Host "Option 4: Online KMS"
        Write-Host "Option 4: Install Auto-Renewal"
        Write-Host "Press any key to go back..."
        Write-Host "Option 2: Activate - Office"
        break
    }
    4 {
        # 4
        Write-Host "Option 1: HWID"
        break
    }
    5 {
        # 5
        Write-Host "Option 3: KMS38"
        Write-Host "Option 1: KMS38 Activation"
        break
    }
    6 {
        # 6
        Write-Host "Option 4: Online KMS"
        Write-Host "Option 4: Install Auto-Renewal"
        Write-Host "Press any key to go back..."
        Write-Host "Option 1: Activate - Windows"
        break
    }
    7 {
        # 7
        Write-Host "Manual ..."
        break
    }
    8 {
        # 8
        Write-Host "Goto Scheduler (3rd Radio Button above black window)"
        Write-Host "Press Office reactivation (2nd button on right side)"
        Write-Host "Goto Activation (1st Radio Button above black window)"
        Write-Host "Press Activate Office (2nd button on middle section)"
        break
    }
    9 {
        # 9
        Write-Host "Goto Scheduler (3rd Radio Button above black window)"
        Write-Host "Press Windows reactivation (1st button on right side)"
        Write-Host "Goto Activation (1st Radio Button above black window)"
        Write-Host "Press Activate Windows (1st button on middle section)"
        break
    }
    default {
        # Default
        Write-Host "Manually activate by other methods ..."
        break
    }
}
Write-Host ""
Write-Host "##################################################"
Write-Host ""
Write-Host ""
Write-Host ""
Write-Host "Ready? Let's go ..."
pause
Write-Host ""

# Run with unattended mode arguments
switch ($activation_method) {
    1 {
        # 1
        try {
            # new
            irm https://get.activated.win | iex
        } catch {
            # old
            irm https://massgrave.dev/get | iex
        }
        break
    }
    2 {
        # 2
        Get-ChildItem -Path $dir_extractedfile_kms -Recurse -Filter "*.cmd" | ForEach-Object { Start-Process -FilePath $_.FullName -ArgumentList "`/Ohook" -Wait }
        break
    }
    3 {
        # 3
        Get-ChildItem -Path $dir_extractedfile_kms -Recurse -Filter "*.cmd" | ForEach-Object { Start-Process -FilePath $_.FullName -ArgumentList "`/KMS-RenewalTask" -Wait }
        Get-ChildItem -Path $dir_extractedfile_kms -Recurse -Filter "*.cmd" | ForEach-Object { Start-Process -FilePath $_.FullName -ArgumentList "`/KMS-Office" -Wait }
        break
    }
    4 {
        # 4
        Get-ChildItem -Path $dir_extractedfile_kms -Recurse -Filter "*.cmd" | ForEach-Object { Start-Process -FilePath $_.FullName -ArgumentList "`/HWID" -Wait }
        break
    }
    5 {
        # 5
        Get-ChildItem -Path $dir_extractedfile_kms -Recurse -Filter "*.cmd" | ForEach-Object { Start-Process -FilePath $_.FullName -ArgumentList "`/KMS38" -Wait }
        break
    }
    6 {
        # 6
        Get-ChildItem -Path $dir_extractedfile_kms -Recurse -Filter "*.cmd" | ForEach-Object { Start-Process -FilePath $_.FullName -ArgumentList "`/KMS-RenewalTask" -Wait }
        Get-ChildItem -Path $dir_extractedfile_kms -Recurse -Filter "*.cmd" | ForEach-Object { Start-Process -FilePath $_.FullName -ArgumentList "`/KMS-Windows" -Wait }
        break
    }
    7 {
        # 7
        Get-ChildItem -Path $dir_extractedfile_kms -Recurse -Filter "*.exe" | ForEach-Object { Start-Process -FilePath $_.FullName -ArgumentList "" -Wait }
        break
    }
    8 {
        # 8
        Get-ChildItem -Path $dir_extractedfile_kms -Recurse -Filter "*.exe" | ForEach-Object { Start-Process -FilePath $_.FullName -ArgumentList "`/sched=ofs" -Wait }
        Get-ChildItem -Path $dir_extractedfile_kms -Recurse -Filter "*.exe" | ForEach-Object { Start-Process -FilePath $_.FullName -ArgumentList "`/ofs=act" -Wait }
        break
    }
    9 {
        # 9
        Get-ChildItem -Path $dir_extractedfile_kms -Recurse -Filter "*.exe" | ForEach-Object { Start-Process -FilePath $_.FullName -ArgumentList "`/sched=win" -Wait }
        Get-ChildItem -Path $dir_extractedfile_kms -Recurse -Filter "*.exe" | ForEach-Object { Start-Process -FilePath $_.FullName -ArgumentList "`/win=act" -Wait }
        break
    }
    default {
        # Default
        Write-Host "No automatic activation added ..."
        break
    }
}

Write-Host ""

# in case antivirus block offline KMS
if ((7 -le $activation_method) -and ($activation_method -le 9)) {
    # open directory with KMS
    Invoke-Item -Path $dir_extractedfile_kms
}

Write-Host ""

# Add to Defender exclusion
# for KMS options or Offline activation
if (($activation_method -eq 3) -or ($activation_method -eq 6)) {
    # MAS
    $dir_sys_kms_task = "$env:ProgramFiles\Activation-Renewal"
} elseif ((7 -le $activation_method) -and ($activation_method -le 9)) {
    # KMSAuto_Lite
    $dir_sys_kms_task = "$env:SystemRoot\KMSAutoS"
} else {
    # default
    $dir_sys_kms_task = $dir_extractedfile_kms
}
Add-MpPreference -ExclusionPath $dir_sys_kms_task

Write-Host ""

# Task Schedule
# Start-Process -FilePath "taskschd.msc" -Wait

Write-Host ""

# Run Scheduled Task
# for KMS options
if (($activation_method -eq 3) -or ($activation_method -eq 6)) {
    # MAS
    Get-ScheduledTask -TaskName *Activation* | Start-ScheduledTask
} elseif ((7 -le $activation_method) -and ($activation_method -le 9)) {
    # KMSAuto_Lite
    Get-ScheduledTask -TaskName *KMSAuto* | Start-ScheduledTask
} else {
    # default
    Write-Host "No scehduled activation task added ..."
}

Write-Host ""

# final

# clear Windows Defender History
# Clear-WinDefHist

# Delete
Get-ChildItem -Path $dir_extractedfile_kms -Recurse | Remove-Item -Recurse -Force

Clear-PSHistory

Write-Host ""

Write-Host "Terminating script-kms.ps1 ..."
pause


# ==================================================
# Notes
# ==================================================
