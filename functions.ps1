# functions.ps1
# ==================================================
# Description
# ==================================================
# Usage
# ==================================================


# Write-Host "Starting functions.ps1 ..."

# To download and include
# Invoke-Expression $($(Invoke-WebRequest "https://raw.githubusercontent.com/tedzhangzg/scripts/main/functions.ps1" -UseBasicParsing).Content)



# Clear Powershell History
# 
# Usage
# Clear-PSHistory
# 
Function Clear-PSHistory() {
    if (Test-Path -Path (Get-PSReadlineOption).HistorySavePath) {
        Remove-Item -Path $(Split-Path -Path (Get-PSReadlineOption).HistorySavePath -Parent) -Recurse
    }
    Write-Host "Powershell history cleared."
}



# Clear Windows Defender History
# 
# Usage
# Clear-WinDefHist
# 
Function Clear-WinDefHist() {
    Set-MpPreference -ScanPurgeItemsAfterDelay 1
    Get-ChildItem -Path "$env:ProgramData\Microsoft\Windows Defender\Scans\History\Service" -Recurse | Remove-Item -Recurse -Force
}



# Autodetect processor Architecture
# 
# Usage
# Autodetect-ProcessorArchitecture
# 
Function Autodetect-ProcessorArchitecture() {

    # Get from API
    $val_cimwin32proc_arch = $(Get-WmiObject -Class "Win32_Processor").Architecture

    # Interpret value
    switch ($val_cimwin32proc_arch) {
        0 {
            # 0
            $processorArchitecture = "x86"
            # Done
            break
        }
        1 {
            # 1
            $processorArchitecture = "MIPS"
            # Done
            break
        }
        2 {
            # 2
            $processorArchitecture = "Alpha"
            # Done
            break
        }
        3 {
            # 3
            $processorArchitecture = "PowerPC"
            # Done
            break
        }
        5 {
            # 5
            $processorArchitecture = "ARM"
            # Done
            break
        }
        6 {
            # 6
            $processorArchitecture = "ia64"
            # Done
            break
        }
        9 {
            # 9
            $processorArchitecture = "x64"
            # Done
            break
        }
        12 {
            # 12
            $processorArchitecture = "ARM64"
            # Done
            break
        }
        default {
            # Default
            Write-Host "Unknown architecture: $val_cimwin32proc_arch"
            break outer
        }
    }

    return $processorArchitecture

}



# Autodetect OS bit
# 
# Usage
# Autodetect-OSBit
# 
Function Autodetect-OSBit() {

    # Return
    if ([Environment]::Is64BitOperatingSystem) {
        return "x64"
    } else {
        return "x86"
    }

}



# Check Windows 11
# 
# Usage
# Is-Win11
# 
Function Is-Win11() {
    return ([System.Environment]::OSVersion.Version.Build -ge 22000)
}
# 
# Notes
# [System.Environment]::OSVersion.Version.Major
# [System.Environment]::OSVersion.Version.Minor
# [System.Environment]::OSVersion.Version.Build
# 
# Check if Server or Desktop
# (Get-CimInstance -ClassName "Win32_OperatingSystem").ProductType
# (Get-WmiObject -Class "Win32_OperatingSystem").ProductType



# location of start menu items, desktops
# 
# local machine
$dir_startmenuprograms_allusers = "$env:ProgramData\Microsoft\Windows\Start Menu\Programs"
# C:\ProgramData\Microsoft\Windows\Start Menu\Programs
$dir_desktop_allusers = "$env:PUBLIC\Desktop"
# C:\Users\Public\Desktop
# 
# current user
$dir_startmenuprograms_currentuser = "$env:APPDATA\Microsoft\Windows\Start Menu\Programs"
# C:\Users\$username\AppData\Roaming\Microsoft\Windows\Start Menu\Programs
$dir_desktop_currentuser = "$env:USERPROFILE\Desktop"
# C:\Users\User\Desktop



# Get URL from winget
# 
# Usage
# Get-URL-FromWinget "$app_wgname" "$app_architecture"
# 
# Useful for manual install or when hash isn't updated in manifest
Function Get-URL-FromWinget($app_wgname, $app_architecture) {

    # winget show - return array
    switch ($app_architecture) {
        "x64x86" {
            # universal x64x86
            $arr_wgshow = $(winget show --id $app_wgname)
            # Done
            break
        }
        "x64" {
            # x64
            $arr_wgshow = $(winget show --id $app_wgname -a "x64")
            # Done
            break
        }
        "x86" {
            # x86
            $arr_wgshow = $(winget show --id $app_wgname -a "x86")
            # Done
            break
        }
        default {
            # Default
            Write-Host "Architecture not found"
            break outer
        }
    }

    # Search array for "Installer Url" - return 1-element array
    $arr_wgshow_url = $arr_wgshow -match "Installer Url"

    # Get string value from 1-element array
    $str_element = $arr_wgshow_url[0]

    # Get URL
    $url = $str_element.Substring($str_element.IndexOf(": ") + 2)

    # Return
    return $url

}



# Remove Folder recursively, preventing error if not exist
# 
# Usage
# Remov-Folde "$path_folder"
# 
Function Remov-Folde($path_folder) {
    if (Test-Path -Path $path_folder) {
        Get-Item -Path $path_folder | Remove-Item -Recurse -Force
    }
}



# Create Folder, preventing error if exist
# 
# Usage
# Creat-NewEmpty-Folde "$path_folder"
# 
Function Creat-NewEmpty-Folde($path_folder) {
    Remov-Folde $path_folder
    New-Item -ItemType "directory" -Path $path_folder -Force | Out-Null
}



# Download Installer
# 
# Usage
# Downloa-Installe "$url" "$dir_installer"
# 
Function Downloa-Installe($url, $dir_installer) {
    Write-Host "Downloading $dir_installer ...."

    # Create new folder
    Creat-NewEmpty-Folde $dir_installer
    
    # Download
    Push-Location -Path $dir_installer
    curl.exe -L -O $url
    Pop-Location

    Write-Host "... Done Downloading $dir_installer"
}



# Install App
# 
# Usage
# Instal-Ap "$dir_installer" "$install_args"
# 
Function Instal-Ap($dir_installer, $install_args) {
    Write-Host "Installing $dir_installer ..."
    
    # Get installer file extension if null
    if ($null -eq $installer_fileext) {
        $installer_fileext = (Get-ChildItem -Path $dir_installer).Extension.Substring(1)
    }
    
    # Install, based on what the extension is
    if ( ($installer_fileext -eq "msi") -or ($installer_fileext -eq "msp") -or ($installer_fileext -eq "exe") ) {
        Invoke-Expression "Get-ChildItem -Path `$dir_installer -Recurse -Filter *.`$installer_fileext | ForEach-Object { Start-Process -FilePath `$_.FullName -ArgumentList `$install_args -Wait }"
    } elseif ( ($installer_fileext -like "app*") -or ($installer_fileext -like "msix*") ) {
        Invoke-Expression "Get-ChildItem -Path `$dir_installer -Recurse -Filter *.`$installer_fileext | ForEach-Object { Add-AppxPackage -Path `$_.FullName }"
        # Invoke-Expression "Get-ChildItem -Path `$dir_installer -Recurse -Filter *.`$installer_fileext | ForEach-Object { Add-AppxProvisionedPackage -Online -PackagePath `$_.FullName -SkipLicense }"
    }
    
    # Clear var for next use
    Remove-Variable installer_fileext
    
    # Notes
    # Full commands that Invoke Expression actually do
    # Get-ChildItem -Path $dir_installer -Recurse -Filter *.$installer_fileext | ForEach-Object { Start-Process -FilePath $_.FullName -ArgumentList $install_args -Wait }
    # Get-ChildItem -Path $dir_installer -Recurse -Filter *.$installer_fileext | ForEach-Object { Add-AppxPackage -Path $_.FullName }
    # Get-ChildItem -Path $dir_installer -Recurse -Filter *.$installer_fileext | ForEach-Object { Add-AppxProvisionedPackage -Online -PackagePath $_.FullName -SkipLicense }

    Write-Host "... Done Installing $dir_installer"
}

# Write-Host ""

# Write-Host "Terminating functions.ps1 ..."
# pause


# ==================================================
# Notes
# ==================================================
