# script-allapps.ps1
# ==================================================
# Description
# This script installs a set of applications on Windows systems.
# It includes both online and offline installation modes,
# and supports different processor architectures (ARM64, Intel x64, Intel x86).
# It also handles various Windows features and components.
# ==================================================
# Usage
# Run the script in PowerShell with administrative privileges.
# ==================================================


Write-Host "Starting script-allapps.ps1 ..."

# include
. ".\functions.ps1"
. ".\urls.ps1"
. ".\values.ps1"

# var
# $var = ""

# create temp folder
$tmp_dir = "$env:TEMP\tempappdlinst"
Creat-NewEmpty-Folde $tmp_dir

Write-Host ""
Write-Host "================================================================================"
Write-Host "Script - Install all apps"
Write-Host "================================================================================"
Write-Host ""

# processor architecture
Write-Host "Processor architecture"
# autodetect
Write-Host "Autodetect processor architecture: $(Autodetect-ProcessorArchitecture)"
# list
Write-Host "(1) arm64"
Write-Host "(2) x64"
Write-Host "(3) x86"
# Write-Host "(4) arm"
# Write-Host "(5) ia64"
# Write-Host "(6) ppc"
# Write-Host "(7) decalpha"
# Write-Host "(8) mips"
# Write-Host "(9) x86-16"
# ask
while ($app_installer_architecture -notin 1..2) {
    # [int]$app_installer_architecture = Read-Host -Prompt "Enter number "
    Write-Host "Enter number "
    $app_installer_architecture = 2
}
Write-Host "CONFIRMED - architecture: $app_installer_architecture"

# get architecture suffix
switch ($app_installer_architecture) {
    1 {
        # 1
        $arch_name = "arm64"
        break
    }
    2 {
        # 2
        $arch_name = "x64"
        break
    }
    3 {
        # 3
        $arch_name = "x86"
        break
    }
    default {
        # Default
        Write-Host "Invalid architecture"
        break
    }
}

Write-Host ""
Write-Host ""

# Win version
Write-Host "Windows Version"
# autodetect
Write-Host "Autodetect Windows Build: $([System.Environment]::OSVersion.Version.Build)"
Write-Host "Generally: above 20000 is Win11, below 20000 is Win10"
# list
Write-Host "(1) Windows 11"
Write-Host "(2) Windows 10"
# ask
while ($win_version -notin 1..2) {
    [int]$win_version = Read-Host -Prompt "Enter number "
}

Write-Host ""
Write-Host ""

# mode
Write-Host "Mode"
# list
Write-Host "(1) Online Install"
Write-Host "(2) Offline Install"
# ask
while ($mode_onoffdown -notin 1..3) {
    # [int]$mode_onoffdown = Read-Host -Prompt "Enter number "
    Write-Host "Enter number "
    $mode_onoffdown = 1
}
Write-Host "CONFIRMED - mode: $mode_onoffdown"

Write-Host ""
Write-Host ""

# Documentation
##################################################
##################################################
Write-Host "List of Apps"
##################################################
Write-Host "---------- PreReq ----------"
Write-Host "1 WinGet"
Write-Host "3 enable - Developer mode"
##################################################
Write-Host "---------- Windows Features ----------"
Write-Host "11 NetFx3"
Write-Host "12 Microsoft-Windows-Subsystem-Linux"
Write-Host "13 VirtualMachinePlatform"
Write-Host "14 Linux Kernel Update"
Write-Host "15 HypervisorPlatform"
Write-Host "16 Microsoft-Hyper-V"
Write-Host "17 Containers"
Write-Host "19 NTVDM"
Write-Host "20 disable - MicrosoftWindowsPowerShellV2Root"
##################################################
Write-Host "---------- Windows Capabilities ----------"
Write-Host "31 remove - Microsoft.Windows.PowerShell.ISE"
##################################################
Write-Host "---------- dot NET ----------"
Write-Host "41 dot NET 10 HostingBundle DesktopRuntime"
Write-Host "42 dot NET 8 HostingBundle DesktopRuntime"
Write-Host "43 dot NET 6 HostingBundle DesktopRuntime"
Write-Host "44 dot NET 3.1 HostingBundle DesktopRuntime"
Write-Host "45 dot NET 2.1 HostingBundle"
##################################################
Write-Host "---------- dot NET Framework ----------"
Write-Host "51 dot NET Framework 4.8.1"
Write-Host "52 dot NET Framework 1.1 with SP1"
##################################################
Write-Host "---------- Visual C++ ----------"
Write-Host "61 Visual C++ 2005"
Write-Host "62 Visual C++ 2008"
Write-Host "63 Visual C++ 2010"
Write-Host "64 Visual C++ 2012"
Write-Host "65 Visual C++ 2013"
Write-Host "66 Visual C++ 2015+"
Write-Host "67 Visual C++ 14"
##################################################
Write-Host "---------- C++ Desktop Bridge ----------"
Write-Host "71 C++ Desktop Bridge 11"
Write-Host "72 C++ Desktop Bridge 12"
##################################################
Write-Host "---------- Dev Env ----------"
Write-Host "81 Python 3"
Write-Host "82 Python 2"
##################################################
Write-Host "---------- Dev IDEs ----------"
Write-Host "91 Sublime Text"
##################################################
##################################################
Write-Host "##############################"
Write-Host "------------------------------"
Write-Host "100 ---------- Restart ----------"
Write-Host "------------------------------"
Write-Host "##############################"
##################################################
##################################################
Write-Host "---------- System Apps ----------"
Write-Host "101 Microsoft PowerShell"
Write-Host "102 Microsoft Windows Terminal"
Write-Host "103 Microsoft Visual Studio Code"
Write-Host "104 Microsoft Windows Subsystem for Linux"
##################################################
Write-Host "---------- Apple Apps ----------"
Write-Host "111 Apple iTunes"
##################################################
Write-Host "---------- Microsoft Apps ----------"
Write-Host "121 Microsoft Edge"
Write-Host "122 Microsoft Teams"
Write-Host "123 Microsoft Skype"
Write-Host "124 Microsoft Windows Essentials"
##################################################
Write-Host "---------- Google Apps ----------"
Write-Host "131 Google Chrome"
Write-Host "132 Google Drive"
##################################################
Write-Host "---------- Amazon Apps ----------"
##################################################
Write-Host "---------- Meta Apps ----------"
Write-Host "141 Meta Messenger"
##################################################
Write-Host "---------- Adobe Apps ----------"
Write-Host "151 Adobe Acrobat Reader"
##################################################
Write-Host "---------- Cloud Apps ----------"
Write-Host "161 Dropbox"
##################################################
Write-Host "---------- Communication Apps ----------"
Write-Host "171 Zoom"
Write-Host "172 Discord"
Write-Host "173 Telegram"
Write-Host "174 WhatsApp"
Write-Host "175 WeChat"
##################################################
Write-Host "---------- Utilities Apps ----------"
Write-Host "181 TeamViewer"
Write-Host "182 Archiving - SevenZip WinRAR"
Write-Host "183 VLC"
Write-Host "184 Java 8"
Write-Host "185 VPN - OpenVPN WireGuard"
Write-Host "186 Firefox"
Write-Host "187 Thunderbird"
Write-Host "188 OBS"
Write-Host "190 LibreOffice"
##################################################
Write-Host "---------- Office Apps ----------"
Write-Host "200 Microsoft Office"
##################################################
Write-Host "---------- Miscellaneous ----------"
Write-Host ""
##################################################
##################################################

# app numbers to install
# from
while ($appnum_toinstall_from -notin 1..200) {
    [int]$appnum_toinstall_from = Read-Host -Prompt "Enter number - App number to install from "
}
# to
[int]$appnum_toinstall_to = Read-Host -Prompt "Enter number - App number to install to (leave blank if all) "
if ( ($appnum_toinstall_to -eq "") -or ($appnum_toinstall_to -lt $appnum_toinstall_from) ) {
    $appnum_toinstall_to = 200
}

Write-Host ""
Write-Host ""

# WinGet
# 
# param
$app_num = 1
$app_shortname = "WinGet"
$app_toinclude = (Get-Variable -Name $("app_toinclude_" + $app_shortname)).Value
# 
# main Install/Download/Execute
if (($app_num -in $appnum_toinstall_from..$appnum_toinstall_to) -and ($app_toinclude -eq 1)) {
    Start-Process -FilePath "powershell.exe" -ArgumentList ".\script-winget.ps1" -Wait
}
# 
# clear param
# Remove-Variable path_file_shortcut
# 
# done

##################################################
##################################################
# special section
# test WinGet
##################################################
if (($mode_onoffdown -ne 2) -and ([System.Environment]::OSVersion.Version.Major -ge 10)) {

    try {
        winget search --id "Google.Chrome" --accept-source-agreements
        Write-Host ""
        winget -v
    } catch {
        Write-Host ""
        Write-Host "Error"
        Write-Host "WinGet is not installed"
        Write-Host "Please install WinGet before continuing"
        Write-Host ""
        Write-Host ""
        Write-Host "Script terminated ..."
        pause
        break
    }

    Write-Host ""
}
##################################################
##################################################

# enable - Developer mode
# 
# param
$app_num = 3
$app_shortname = "EnableDevMode"
$app_toinclude = (Get-Variable -Name $("app_toinclude_" + $app_shortname)).Value
# 
# main Install/Download/Execute
if (($app_num -in $appnum_toinstall_from..$appnum_toinstall_to) -and ($app_toinclude -eq 1)) {

    Write-Host "Enabling Developer Mode ..."
    New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\AppModelUnlock" -Name "AllowDevelopmentWithoutDevLicense" -PropertyType "DWORD" -Value "1" -Force | Out-Null
    Write-Host "... Done enabling"

    Write-Host ""

}
# 
# clear param
# Remove-Variable path_file_shortcut
# 
# done

# NetFx3
# 
# param
$app_num = 11
$app_shortname = "NetFx3"
$app_toinclude = (Get-Variable -Name $("app_toinclude_" + $app_shortname)).Value
switch ([Environment]::OSVersion.Version.Build) {
    {($_ -ge 26200) -and ($_ -le 26200)}
    {
        # build 26200
        # Windows 11 version 25H2
        # Windows 11 Enterprise LTSC ?
        # Windows Server LTSC ?
        # Windows Server version ?
        $dir_installer = "netfx3\b26200x64"
        break
    }
    {($_ -ge 26100) -and ($_ -le 26100)}
    {
        # build 26100
        # Windows 11 version 24H2
        # Windows 11 Enterprise LTSC 2024
        # Windows Server LTSC 2025
        # Windows Server version ?
        $dir_installer = "netfx3\b26100x64"
        break
    }
    {($_ -ge 25398) -and ($_ -le 25398)}
    {
        # build 25398
        # Windows 11 version ?
        # Windows 11 Enterprise LTSC ?
        # Windows Server LTSC ?
        # Windows Server version 23H2
        $dir_installer = "netfx3\b26100x64"
        break
    }
    {($_ -ge 20348) -and ($_ -le 20348)}
    {
        # build 20348
        # Windows ?
        # Windows ? Enterprise LTSC ?
        # Windows Server LTSC 2022
        # Windows Server version ?
        $dir_installer = "netfx3\b20348x64"
        break
    }
    {($_ -ge 19045) -and ($_ -le 19045)}
    {
        # build 19045
        # Windows 10 version 22H2
        # Windows ? Enterprise LTSC ?
        # Windows Server LTSC ?
        # Windows Server version ?
        $dir_installer = "netfx3\b19045x64"
        break
    }
    {($_ -ge 19044) -and ($_ -le 19044)}
    {
        # build 19044
        # Windows 10 version 21H2
        # Windows 10 Enterprise LTSC 2021
        # Windows Server LTSC ?
        # Windows Server version ?
        $dir_installer = "netfx3\b19044x64"
        break
    }
    {($_ -ge 17763) -and ($_ -le 17763)}
    {
        # build 17763
        # Windows 10 version 1809
        # Windows 10 Enterprise LTSC 2019
        # Windows Server LTSC 2019
        # Windows Server version 1809
        $dir_installer = "netfx3\b17763x64"
        break
    }
    {($_ -ge 14393) -and ($_ -le 14393)}
    {
        # build 14393
        # Windows 10 version 1607
        # Windows 10 Enterprise LTSB 2016
        # Windows Server LTSC 2016
        # Windows Server version ?
        $dir_installer = "netfx3\b14393x64"
        break
    }
    {($_ -ge 10240) -and ($_ -le 10240)}
    {
        # build 10240
        # Windows 10 version 1507
        # Windows 10 Enterprise LTSB 2015
        # Windows Server LTSC ?
        # Windows Server version ?
        $dir_installer = "netfx3\b10240x64"
        break
    }
    default
    {
        # default
        Write-Host "unknown build"
        $dir_installer = "netfx3\b19044x64"
        break
    }
}
# 
# main Install/Download/Execute
if (($app_num -in $appnum_toinstall_from..$appnum_toinstall_to) -and ($app_toinclude -eq 1)) {

    Write-Host "Enabling $app_shortname ..."
    if (-Not (Test-Path -Path "$dir_installer\sxs.zip")) {
        Get-WindowsOptionalFeature -Online -FeatureName $app_shortname | Enable-WindowsOptionalFeature -Online -All -NoRestart | Out-Null
    } else {
        $dir_extract = $tmp_dir
        Expand-Archive -Path "$dir_installer\sxs.zip" -DestinationPath $dir_extract -Force
        Get-WindowsOptionalFeature -Online -FeatureName $app_shortname | Enable-WindowsOptionalFeature -Online -Source "$dir_extract\sxs" -All -NoRestart | Out-Null
        Get-ChildItem -Path $dir_extract -Recurse | Remove-Item -Recurse -Force
    }
    Write-Host "... Done enabling"

    Write-Host ""

}
# 
# clear param
# Remove-Variable path_file_shortcut
# 
# done

# Microsoft-Windows-Subsystem-Linux
# 
# param
$app_num = 12
$app_shortname = "Microsoft-Windows-Subsystem-Linux"
$app_shortname_without_dashes = "MicrosoftWindowsSubsystemLinux"
# $app_toinclude = (Get-Variable -Name $("app_toinclude_" + $app_shortname)).Value
$app_toinclude = (Get-Variable -Name $("app_toinclude_" + $app_shortname_without_dashes)).Value
# 
# main Install/Download/Execute
if (($app_num -in $appnum_toinstall_from..$appnum_toinstall_to) -and ($app_toinclude -eq 1)) {

    Write-Host "Enabling $app_shortname ..."
    Get-WindowsOptionalFeature -Online -FeatureName $app_shortname | Enable-WindowsOptionalFeature -Online -All -NoRestart | Out-Null
    Write-Host "... Done enabling"

    Write-Host ""

}
# 
# clear param
# Remove-Variable path_file_shortcut
# 
# done

# VirtualMachinePlatform
# 
# param
$app_num = 13
$app_shortname = "VirtualMachinePlatform"
$app_toinclude = (Get-Variable -Name $("app_toinclude_" + $app_shortname)).Value
# 
# main Install/Download/Execute
if (($app_num -in $appnum_toinstall_from..$appnum_toinstall_to) -and ($app_toinclude -eq 1)) {

    Write-Host "Enabling $app_shortname ..."
    Get-WindowsOptionalFeature -Online -FeatureName $app_shortname | Enable-WindowsOptionalFeature -Online -All -NoRestart | Out-Null
    Write-Host "... Done enabling"

    Write-Host ""

}
# 
# clear param
# Remove-Variable path_file_shortcut
# 
# done

# Linux Kernel Update
# 
# param
$app_num = 14
$app_shortname = "WSL2Kernel"
$app_toinclude = (Get-Variable -Name $("app_toinclude_" + $app_shortname)).Value
$url_appspecific = $url_WSL2Kernel_x64
$dir_installer = $app_shortname + "_" + $arch_name
$install_args = "`/passive"
# 
# main Install/Download/Execute
if (($app_num -in $appnum_toinstall_from..$appnum_toinstall_to) -and ($app_toinclude -eq 1)) {

    # Download
    if (-Not (Test-Path -Path $dir_installer)) {
        $url = $url_appspecific
        Downloa-Installe $url $dir_installer
    }
    if ($mode_onoffdown -ne 3) {
        # Offline
        Instal-Ap $dir_installer $install_args
    }
    # set wsl2 as default
    wsl --set-default-version 2

    Write-Host ""

}
# 
# clear param
# Remove-Variable path_file_shortcut
# 
# done

# HypervisorPlatform
# 
# param
$app_num = 15
$app_shortname = "HypervisorPlatform"
$app_toinclude = (Get-Variable -Name $("app_toinclude_" + $app_shortname)).Value
# 
# main Install/Download/Execute
if (($app_num -in $appnum_toinstall_from..$appnum_toinstall_to) -and ($app_toinclude -eq 1)) {

    Write-Host "Enabling $app_shortname ..."
    Get-WindowsOptionalFeature -Online -FeatureName $app_shortname | Enable-WindowsOptionalFeature -Online -All -NoRestart | Out-Null
    Write-Host "... Done enabling"

    Write-Host ""

}
# 
# clear param
# Remove-Variable path_file_shortcut
# 
# done

# Microsoft-Hyper-V
# 
# param
$app_num = 16
$app_shortname = "Microsoft-Hyper-V"
$app_shortname_without_dashes = "MicrosoftHyperV"
# $app_toinclude = (Get-Variable -Name $("app_toinclude_" + $app_shortname)).Value
$app_toinclude = (Get-Variable -Name $("app_toinclude_" + $app_shortname_without_dashes)).Value
# 
# main Install/Download/Execute
if (($app_num -in $appnum_toinstall_from..$appnum_toinstall_to) -and ($app_toinclude -eq 1)) {

    Write-Host "Enabling $app_shortname ..."
    Get-WindowsOptionalFeature -Online -FeatureName $app_shortname | Enable-WindowsOptionalFeature -Online -All -NoRestart | Out-Null
    Write-Host "... Done enabling"

    Write-Host ""

}
# 
# clear param
# Remove-Variable path_file_shortcut
# 
# done

# Containers
# 
# param
$app_num = 17
$app_shortname = "Containers"
$app_toinclude = (Get-Variable -Name $("app_toinclude_" + $app_shortname)).Value
# 
# main Install/Download/Execute
if (($app_num -in $appnum_toinstall_from..$appnum_toinstall_to) -and ($app_toinclude -eq 1)) {

    Write-Host "Enabling $app_shortname ..."
    Get-WindowsOptionalFeature -Online -FeatureName $app_shortname | Enable-WindowsOptionalFeature -Online -All -NoRestart | Out-Null
    Write-Host "... Done enabling"

    Write-Host ""

}
# 
# clear param
# Remove-Variable path_file_shortcut
# 
# done

# NTVDM
# 
# param
$app_num = 19
$app_shortname = "NTVDM"
$app_toinclude = (Get-Variable -Name $("app_toinclude_" + $app_shortname)).Value
# 
# main Install/Download/Execute
if (($app_num -in $appnum_toinstall_from..$appnum_toinstall_to) -and ($app_toinclude -eq 1)) {

    if (-Not [Environment]::Is64BitOperatingSystem) {
        Write-Host "Enabling $app_shortname ..."
        Get-WindowsOptionalFeature -Online -FeatureName $app_shortname | Enable-WindowsOptionalFeature -Online -All -NoRestart | Out-Null
        Write-Host "... Done enabling"

        Write-Host ""

    }

}
# 
# clear param
# Remove-Variable path_file_shortcut
# 
# done

# disable - MicrosoftWindowsPowerShellV2Root
# 
# param
$app_num = 20
$app_shortname = "MicrosoftWindowsPowerShellV2Root"
$app_toinclude = (Get-Variable -Name $("app_toinclude_" + $app_shortname)).Value
# 
# main Install/Download/Execute
if (($app_num -in $appnum_toinstall_from..$appnum_toinstall_to) -and ($app_toinclude -eq 1)) {

    Write-Host "Disabling $app_shortname ..."
    Get-WindowsOptionalFeature -Online -FeatureName $app_shortname | Disable-WindowsOptionalFeature -Online -NoRestart | Out-Null
    Write-Host "... Done disabling"

    Write-Host ""

}
# 
# clear param
# Remove-Variable path_file_shortcut
# 
# done

# remove - Microsoft.Windows.PowerShell.ISE
# 
# param
$app_num = 31
$app_shortname = "PowerShellISE"
$app_toinclude = (Get-Variable -Name $("app_toinclude_" + $app_shortname)).Value
# 
# main Install/Download/Execute
if (($app_num -in $appnum_toinstall_from..$appnum_toinstall_to) -and ($app_toinclude -eq 1)) {

    Write-Host "Removing Microsoft.Windows.PowerShell.ISE ..."
    Get-WindowsCapability -Online -Name "Microsoft.Windows.PowerShell.ISE*" | Remove-WindowsCapability -Online | Out-Null
    Write-Host "... Done removing"

    Write-Host ""

}
# 
# clear param
# Remove-Variable path_file_shortcut
# 
# done

# dot NET 10 HostingBundle
# 
# param
$app_num = 41
$app_shortname = "dotNETHB10"
$app_toinclude = (Get-Variable -Name $("app_toinclude_" + $app_shortname)).Value
$app_wgname = "Microsoft.DotNet.HostingBundle.10"
$dir_installer = $app_shortname + "_" + "a64x64"
$install_args = "`/passive `/norestart"
# 
# main Install/Download/Execute
if (($app_num -in $appnum_toinstall_from..$appnum_toinstall_to) -and ($app_toinclude -eq 1)) {

    if ($false) {
    # if ($mode_onoffdown -eq 1) {
        # Online
        winget install --id $app_wgname
    } else {
        # Download
        if (-Not (Test-Path -Path $dir_installer)) {
            $url = Get-URL-FromWinget $app_wgname "a64x64"
            Downloa-Installe $url $dir_installer
        }
        if ($mode_onoffdown -ne 3) {
            # Offline
            Instal-Ap $dir_installer $install_args
        }
    }

    Write-Host ""

}
# 
# clear param
# Remove-Variable path_file_shortcut
# 
# done

# dot NET 10 DesktopRuntime x86
# 
# param
$app_num = 41
$app_shortname = "dotNETDR10"
$app_toinclude = (Get-Variable -Name $("app_toinclude_" + $app_shortname)).Value
$app_wgname = "Microsoft.DotNet.DesktopRuntime.10"
$dir_installer = $app_shortname + "_" + "x86"
$install_args = "`/passive `/norestart"
# 
# main Install/Download/Execute
if (($app_num -in $appnum_toinstall_from..$appnum_toinstall_to) -and ($app_toinclude -eq 1)) {

    if ($false) {
    # if ($mode_onoffdown -eq 1) {
        # Online
        winget install --id $app_wgname -a "x86"
    } else {
        # Download
        if (-Not (Test-Path -Path $dir_installer)) {
            $url = Get-URL-FromWinget $app_wgname "x86"
            Downloa-Installe $url $dir_installer
        }
        if ($mode_onoffdown -ne 3) {
            # Offline
            Instal-Ap $dir_installer $install_args
        }
    }

    Write-Host ""

}
# 
# clear param
# Remove-Variable path_file_shortcut
# 
# done

# dot NET 10 DesktopRuntime x64
# 
# param
$app_num = 41
$app_shortname = "dotNETDR10"
$app_toinclude = (Get-Variable -Name $("app_toinclude_" + $app_shortname)).Value
$app_wgname = "Microsoft.DotNet.DesktopRuntime.10"
$dir_installer = $app_shortname + "_" + $arch_name
$install_args = "`/passive `/norestart"
# 
# main Install/Download/Execute
if (($app_num -in $appnum_toinstall_from..$appnum_toinstall_to) -and ($app_toinclude -eq 1)) {

    if ($false) {
    # if ($mode_onoffdown -eq 1) {
        # Online
        winget install --id $app_wgname -a $arch_name
    } else {
        # Download
        if (-Not (Test-Path -Path $dir_installer)) {
            $url = Get-URL-FromWinget $app_wgname $arch_name
            Downloa-Installe $url $dir_installer
        }
        if ($mode_onoffdown -ne 3) {
            # Offline
            Instal-Ap $dir_installer $install_args
        }
    }

    Write-Host ""

}
# 
# clear param
# Remove-Variable path_file_shortcut
# 
# done

# dot NET 8 HostingBundle
# 
# param
$app_num = 42
$app_shortname = "dotNETHB8"
$app_toinclude = (Get-Variable -Name $("app_toinclude_" + $app_shortname)).Value
$app_wgname = "Microsoft.DotNet.HostingBundle.8"
$dir_installer = $app_shortname + "_" + "a64x64"
$install_args = "`/passive `/norestart"
# 
# main Install/Download/Execute
if (($app_num -in $appnum_toinstall_from..$appnum_toinstall_to) -and ($app_toinclude -eq 1)) {

    if ($false) {
    # if ($mode_onoffdown -eq 1) {
        # Online
        winget install --id $app_wgname
    } else {
        # Download
        if (-Not (Test-Path -Path $dir_installer)) {
            $url = Get-URL-FromWinget $app_wgname "a64x64"
            Downloa-Installe $url $dir_installer
        }
        if ($mode_onoffdown -ne 3) {
            # Offline
            Instal-Ap $dir_installer $install_args
        }
    }

    Write-Host ""

}
# 
# clear param
# Remove-Variable path_file_shortcut
# 
# done

# dot NET 8 DesktopRuntime x86
# 
# param
$app_num = 42
$app_shortname = "dotNETDR8"
$app_toinclude = (Get-Variable -Name $("app_toinclude_" + $app_shortname)).Value
$app_wgname = "Microsoft.DotNet.DesktopRuntime.8"
$dir_installer = $app_shortname + "_" + "x86"
$install_args = "`/passive `/norestart"
# 
# main Install/Download/Execute
if (($app_num -in $appnum_toinstall_from..$appnum_toinstall_to) -and ($app_toinclude -eq 1)) {

    if ($false) {
    # if ($mode_onoffdown -eq 1) {
        # Online
        winget install --id $app_wgname -a "x86"
    } else {
        # Download
        if (-Not (Test-Path -Path $dir_installer)) {
            $url = Get-URL-FromWinget $app_wgname "x86"
            Downloa-Installe $url $dir_installer
        }
        if ($mode_onoffdown -ne 3) {
            # Offline
            Instal-Ap $dir_installer $install_args
        }
    }

    Write-Host ""

}
# 
# clear param
# Remove-Variable path_file_shortcut
# 
# done

# dot NET 8 DesktopRuntime x64
# 
# param
$app_num = 42
$app_shortname = "dotNETDR8"
$app_toinclude = (Get-Variable -Name $("app_toinclude_" + $app_shortname)).Value
$app_wgname = "Microsoft.DotNet.DesktopRuntime.8"
$dir_installer = $app_shortname + "_" + $arch_name
$install_args = "`/passive `/norestart"
# 
# main Install/Download/Execute
if (($app_num -in $appnum_toinstall_from..$appnum_toinstall_to) -and ($app_toinclude -eq 1)) {

    if ($false) {
    # if ($mode_onoffdown -eq 1) {
        # Online
        winget install --id $app_wgname -a $arch_name
    } else {
        # Download
        if (-Not (Test-Path -Path $dir_installer)) {
            $url = Get-URL-FromWinget $app_wgname $arch_name
            Downloa-Installe $url $dir_installer
        }
        if ($mode_onoffdown -ne 3) {
            # Offline
            Instal-Ap $dir_installer $install_args
        }
    }

    Write-Host ""

}
# 
# clear param
# Remove-Variable path_file_shortcut
# 
# done

# dot NET 6 HostingBundle
# 
# param
$app_num = 43
$app_shortname = "dotNETHB6"
$app_toinclude = (Get-Variable -Name $("app_toinclude_" + $app_shortname)).Value
$app_wgname = "Microsoft.DotNet.HostingBundle.6"
$url_appspecific = $url_dotNETHB6
$dir_installer = $app_shortname + "_" + "a64x64"
$install_args = "`/passive `/norestart"
# 
# main Install/Download/Execute
if (($app_num -in $appnum_toinstall_from..$appnum_toinstall_to) -and ($app_toinclude -eq 1)) {

    if ($false) {
    # if ($mode_onoffdown -eq 1) {
        # Online
        winget install --id $app_wgname
    } else {
        # Download
        if (-Not (Test-Path -Path $dir_installer)) {
            $url = Get-URL-FromWinget $app_wgname "a64x64"
            Downloa-Installe $url $dir_installer
        }
        if ($mode_onoffdown -ne 3) {
            # Offline
            Instal-Ap $dir_installer $install_args
        }
    }

    Write-Host ""

}
# 
# clear param
# Remove-Variable path_file_shortcut
# 
# done

# dot NET 6 DesktopRuntime x86
# 
# param
$app_num = 43
$app_shortname = "dotNETDR6"
$app_toinclude = (Get-Variable -Name $("app_toinclude_" + $app_shortname)).Value
$app_wgname = "Microsoft.DotNet.DesktopRuntime.6"
$url_appspecific = $url_dotNETDR6_x86
$dir_installer = $app_shortname + "_" + "x86"
$install_args = "`/passive `/norestart"
# 
# main Install/Download/Execute
if (($app_num -in $appnum_toinstall_from..$appnum_toinstall_to) -and ($app_toinclude -eq 1)) {

    if ($false) {
    # if ($mode_onoffdown -eq 1) {
        # Online
        winget install --id $app_wgname -a "x86"
    } else {
        # Download
        if (-Not (Test-Path -Path $dir_installer)) {
            $url = Get-URL-FromWinget $app_wgname "x86"
            Downloa-Installe $url $dir_installer
        }
        if ($mode_onoffdown -ne 3) {
            # Offline
            Instal-Ap $dir_installer $install_args
        }
    }

    Write-Host ""

}
# 
# clear param
# Remove-Variable path_file_shortcut
# 
# done

# dot NET 6 DesktopRuntime x64
# 
# param
$app_num = 43
$app_shortname = "dotNETDR6"
$app_toinclude = (Get-Variable -Name $("app_toinclude_" + $app_shortname)).Value
$app_wgname = "Microsoft.DotNet.DesktopRuntime.6"
$url_appspecific = $url_dotNETDR6_x64
$dir_installer = $app_shortname + "_" + $arch_name
$install_args = "`/passive `/norestart"
# 
# main Install/Download/Execute
if (($app_num -in $appnum_toinstall_from..$appnum_toinstall_to) -and ($app_toinclude -eq 1)) {

    if ($false) {
    # if ($mode_onoffdown -eq 1) {
        # Online
        winget install --id $app_wgname -a $arch_name
    } else {
        # Download
        if (-Not (Test-Path -Path $dir_installer)) {
            $url = Get-URL-FromWinget $app_wgname $arch_name
            Downloa-Installe $url $dir_installer
        }
        if ($mode_onoffdown -ne 3) {
            # Offline
            Instal-Ap $dir_installer $install_args
        }
    }

    Write-Host ""

}
# 
# clear param
# Remove-Variable path_file_shortcut
# 
# done

# dot NET 3.1 HostingBundle
# 
# param
$app_num = 44
$app_shortname = "dotNETHB31"
$app_toinclude = (Get-Variable -Name $("app_toinclude_" + $app_shortname)).Value
$app_wgname = "Microsoft.DotNet.HostingBundle.3_1"
$url_appspecific = $url_dotNETHB31
$dir_installer = $app_shortname + "_" + "a64x64"
$install_args = "`/passive `/norestart"
# 
# main Install/Download/Execute
if (($app_num -in $appnum_toinstall_from..$appnum_toinstall_to) -and ($app_toinclude -eq 1)) {

    if ($false) {
    # if ($mode_onoffdown -eq 1) {
        # Online
        winget install --id $app_wgname
    } else {
        # Download
        if (-Not (Test-Path -Path $dir_installer)) {
            $url = Get-URL-FromWinget $app_wgname "a64x64"
            Downloa-Installe $url $dir_installer
        }
        if ($mode_onoffdown -ne 3) {
            # Offline
            Instal-Ap $dir_installer $install_args
        }
    }

    Write-Host ""

}
# 
# clear param
# Remove-Variable path_file_shortcut
# 
# done

# dot NET 3.1 DesktopRuntime x86
# 
# param
$app_num = 44
$app_shortname = "dotNETDR31"
$app_toinclude = (Get-Variable -Name $("app_toinclude_" + $app_shortname)).Value
$app_wgname = "Microsoft.DotNet.DesktopRuntime.3_1"
$url_appspecific = $url_dotNETDR31_x86
$dir_installer = $app_shortname + "_" + "x86"
$install_args = "`/passive `/norestart"
# 
# main Install/Download/Execute
if (($app_num -in $appnum_toinstall_from..$appnum_toinstall_to) -and ($app_toinclude -eq 1)) {

    if ($false) {
    # if ($mode_onoffdown -eq 1) {
        # Online
        winget install --id $app_wgname -a "x86"
    } else {
        # Download
        if (-Not (Test-Path -Path $dir_installer)) {
            $url = Get-URL-FromWinget $app_wgname "x86"
            Downloa-Installe $url $dir_installer
        }
        if ($mode_onoffdown -ne 3) {
            # Offline
            Instal-Ap $dir_installer $install_args
        }
    }

    Write-Host ""

}
# 
# clear param
# Remove-Variable path_file_shortcut
# 
# done

# dot NET 3.1 DesktopRuntime x64
# 
# param
$app_num = 44
$app_shortname = "dotNETDR31"
$app_toinclude = (Get-Variable -Name $("app_toinclude_" + $app_shortname)).Value
$app_wgname = "Microsoft.DotNet.DesktopRuntime.3_1"
$url_appspecific = $url_dotNETDR31_x64
$dir_installer = $app_shortname + "_" + $arch_name
$install_args = "`/passive `/norestart"
# 
# main Install/Download/Execute
if (($app_num -in $appnum_toinstall_from..$appnum_toinstall_to) -and ($app_toinclude -eq 1)) {

    if ($false) {
    # if ($mode_onoffdown -eq 1) {
        # Online
        winget install --id $app_wgname -a $arch_name
    } else {
        # Download
        if (-Not (Test-Path -Path $dir_installer)) {
            $url = Get-URL-FromWinget $app_wgname $arch_name
            Downloa-Installe $url $dir_installer
        }
        if ($mode_onoffdown -ne 3) {
            # Offline
            Instal-Ap $dir_installer $install_args
        }
    }

    Write-Host ""

}
# 
# clear param
# Remove-Variable path_file_shortcut
# 
# done

# dot NET 2.1 HostingBundle
# 
# param
$app_num = 45
$app_shortname = "dotNETHB21"
$app_toinclude = (Get-Variable -Name $("app_toinclude_" + $app_shortname)).Value
# $app_wgname = "Microsoft.DotNet.HostingBundle.2_1"
$url_appspecific = $url_dotNETHB21
$dir_installer = $app_shortname + "_" + "a64x64"
$install_args = "`/passive `/norestart"
# 
# main Install/Download/Execute
if (($app_num -in $appnum_toinstall_from..$appnum_toinstall_to) -and ($app_toinclude -eq 1)) {

    if ($false) {
    # if ($mode_onoffdown -eq 1) {
        # Online
        winget install --id $app_wgname
    } else {
        # Download
        if (-Not (Test-Path -Path $dir_installer)) {
            $url = Get-URL-FromWinget $app_wgname "a64x64"
            Downloa-Installe $url $dir_installer
        }
        if ($mode_onoffdown -ne 3) {
            # Offline
            Instal-Ap $dir_installer $install_args
        }
    }

    Write-Host ""

}
# 
# clear param
# Remove-Variable path_file_shortcut
# 
# done

# dot NET Framework 4.8.1
# 
# param
$app_num = 51
$app_shortname = "dotNETFw481"
$app_toinclude = (Get-Variable -Name $("app_toinclude_" + $app_shortname)).Value
$app_wgname = "Microsoft.DotNet.Framework.DeveloperPack_4"
$url_appspecific = $url_dotNETFw481
$dir_installer = $app_shortname + "_" + "a64x64"
$install_args = "`/passive `/norestart"
# 
# main Install/Download/Execute
if (($app_num -in $appnum_toinstall_from..$appnum_toinstall_to) -and ($app_toinclude -eq 1)) {

    # Download
    if (-Not (Test-Path -Path $dir_installer)) {
        $url = $url_appspecific
        Downloa-Installe $url $dir_installer
        Get-ChildItem -Path $dir_installer | Rename-Item -NewName "ndp481-x86-x64-allos-enu.exe"
    }
    if ($mode_onoffdown -ne 3) {
        # Offline
        Instal-Ap $dir_installer $install_args
    }

    Write-Host ""

}
# 
# clear param
# Remove-Variable path_file_shortcut
# 
# done

# dot NET Framework 1.1 with SP1
# 
# param
$app_num = 52
$app_shortname = "dotNETFw11"
$app_toinclude = (Get-Variable -Name $("app_toinclude_" + $app_shortname)).Value
# $app_wgname = "Microsoft.DotNet.Framework.DeveloperPack_1_1"
$dir_installer = $app_shortname + "_" + "x86"
$dir_ext_installer = $dir_installer + "_ext"
$install_args = "`/passive"
# 
# main Install/Download/Execute
if (($app_num -in $appnum_toinstall_from..$appnum_toinstall_to) -and ($app_toinclude -eq 1)) {

    if ($mode_onoffdown -ne 3) {

        Write-Host "Installing $dir_installer ..."

        # Expand
        Get-ChildItem -Path $dir_installer -Filter *.zip | Expand-Archive -DestinationPath $dir_ext_installer -Force

        # Install
        Start-Process -FilePath "$dir_ext_installer\netfx.msi" -ArgumentList "`/passive" -Wait

        # Remove
        Remove-Item -Path $dir_ext_installer -Recurse -Force

        Write-Host "... Done Installing $dir_installer"

    }

    Write-Host ""

}
# 
# clear param
# Remove-Variable path_file_shortcut
# 
# done

# Visual C++ 2005 x86
# 
# param
$app_num = 61
$app_shortname = "VCPP2005"
$app_toinclude = (Get-Variable -Name $("app_toinclude_" + $app_shortname)).Value
$app_wgname = "Microsoft.VCRedist.2005.x86"
$dir_installer = $app_shortname + "_" + "x86"
$install_args = "`/Q"
# 
# main Install/Download/Execute
if (($app_num -in $appnum_toinstall_from..$appnum_toinstall_to) -and ($app_toinclude -eq 1)) {

    if ($false) {
    # if ($mode_onoffdown -eq 1) {
        # Online
        winget install --id $app_wgname
    } else {
        # Download
        if (-Not (Test-Path -Path $dir_installer)) {
            $url = Get-URL-FromWinget $app_wgname "a64x64"
            Downloa-Installe $url $dir_installer
        }
        if ($mode_onoffdown -ne 3) {
            # Offline
            Instal-Ap $dir_installer $install_args
        }
    }

    Write-Host ""

}
# 
# clear param
# Remove-Variable path_file_shortcut
# 
# done

# Visual C++ 2005 x64
# 
# param
$app_num = 61
$app_shortname = "VCPP2005"
$app_toinclude = (Get-Variable -Name $("app_toinclude_" + $app_shortname)).Value
$app_wgname = "Microsoft.VCRedist.2005.x64"
$dir_installer = $app_shortname + "_" + $arch_name
$install_args = "`/Q"
# 
# main Install/Download/Execute
if (($app_num -in $appnum_toinstall_from..$appnum_toinstall_to) -and ($app_toinclude -eq 1)) {

    if ($false) {
    # if ($mode_onoffdown -eq 1) {
        # Online
        winget install --id $app_wgname
    } else {
        # Download
        if (-Not (Test-Path -Path $dir_installer)) {
            $url = Get-URL-FromWinget $app_wgname "a64x64"
            Downloa-Installe $url $dir_installer
        }
        if ($mode_onoffdown -ne 3) {
            # Offline
            Instal-Ap $dir_installer $install_args
        }
    }

    Write-Host ""

}
# 
# clear param
# Remove-Variable path_file_shortcut
# 
# done

# Visual C++ 2008 x86
# 
# param
$app_num = 62
$app_shortname = "VCPP2008"
$app_toinclude = (Get-Variable -Name $("app_toinclude_" + $app_shortname)).Value
$app_wgname = "Microsoft.VCRedist.2008.x86"
$dir_installer = $app_shortname + "_" + "x86"
$install_args = "`/qb `/norestart"
# 
# main Install/Download/Execute
if (($app_num -in $appnum_toinstall_from..$appnum_toinstall_to) -and ($app_toinclude -eq 1)) {

    if ($false) {
    # if ($mode_onoffdown -eq 1) {
        # Online
        winget install --id $app_wgname
    } else {
        # Download
        if (-Not (Test-Path -Path $dir_installer)) {
            $url = Get-URL-FromWinget $app_wgname "a64x64"
            Downloa-Installe $url $dir_installer
        }
        if ($mode_onoffdown -ne 3) {
            # Offline
            Instal-Ap $dir_installer $install_args
        }
    }

    Write-Host ""

}
# 
# clear param
# Remove-Variable path_file_shortcut
# 
# done

# Visual C++ 2008 x64
# 
# param
$app_num = 62
$app_shortname = "VCPP2008"
$app_toinclude = (Get-Variable -Name $("app_toinclude_" + $app_shortname)).Value
$app_wgname = "Microsoft.VCRedist.2008.x64"
$dir_installer = $app_shortname + "_" + $arch_name
$install_args = "`/qb `/norestart"
# 
# main Install/Download/Execute
if (($app_num -in $appnum_toinstall_from..$appnum_toinstall_to) -and ($app_toinclude -eq 1)) {

    if ($false) {
    # if ($mode_onoffdown -eq 1) {
        # Online
        winget install --id $app_wgname
    } else {
        # Download
        if (-Not (Test-Path -Path $dir_installer)) {
            $url = Get-URL-FromWinget $app_wgname "a64x64"
            Downloa-Installe $url $dir_installer
        }
        if ($mode_onoffdown -ne 3) {
            # Offline
            Instal-Ap $dir_installer $install_args
        }
    }

    Write-Host ""

}
# 
# clear param
# Remove-Variable path_file_shortcut
# 
# done

# Visual C++ 2010 x86
# 
# param
$app_num = 63
$app_shortname = "VCPP2010"
$app_toinclude = (Get-Variable -Name $("app_toinclude_" + $app_shortname)).Value
$app_wgname = "Microsoft.VCRedist.2010.x86"
$dir_installer = $app_shortname + "_" + "x86"
$install_args = "`/passive `/norestart"
# 
# main Install/Download/Execute
if (($app_num -in $appnum_toinstall_from..$appnum_toinstall_to) -and ($app_toinclude -eq 1)) {

    if ($false) {
    # if ($mode_onoffdown -eq 1) {
        # Online
        winget install --id $app_wgname
    } else {
        # Download
        if (-Not (Test-Path -Path $dir_installer)) {
            $url = Get-URL-FromWinget $app_wgname "a64x64"
            Downloa-Installe $url $dir_installer
        }
        if ($mode_onoffdown -ne 3) {
            # Offline
            Instal-Ap $dir_installer $install_args
        }
    }

    Write-Host ""

}
# 
# clear param
# Remove-Variable path_file_shortcut
# 
# done

# Visual C++ 2010 x64
# 
# param
$app_num = 63
$app_shortname = "VCPP2010"
$app_toinclude = (Get-Variable -Name $("app_toinclude_" + $app_shortname)).Value
$app_wgname = "Microsoft.VCRedist.2010.x64"
$dir_installer = $app_shortname + "_" + $arch_name
$install_args = "`/passive `/norestart"
# 
# main Install/Download/Execute
if (($app_num -in $appnum_toinstall_from..$appnum_toinstall_to) -and ($app_toinclude -eq 1)) {

    if ($false) {
    # if ($mode_onoffdown -eq 1) {
        # Online
        winget install --id $app_wgname
    } else {
        # Download
        if (-Not (Test-Path -Path $dir_installer)) {
            $url = Get-URL-FromWinget $app_wgname "a64x64"
            Downloa-Installe $url $dir_installer
        }
        if ($mode_onoffdown -ne 3) {
            # Offline
            Instal-Ap $dir_installer $install_args
        }
    }

    Write-Host ""

}
# 
# clear param
# Remove-Variable path_file_shortcut
# 
# done

# Visual C++ 2012 x86
# 
# param
$app_num = 64
$app_shortname = "VCPP2012"
$app_toinclude = (Get-Variable -Name $("app_toinclude_" + $app_shortname)).Value
$app_wgname = "Microsoft.VCRedist.2012.x86"
$dir_installer = $app_shortname + "_" + "x86"
$install_args = "`/passive `/norestart"
# 
# main Install/Download/Execute
if (($app_num -in $appnum_toinstall_from..$appnum_toinstall_to) -and ($app_toinclude -eq 1)) {

    if ($false) {
    # if ($mode_onoffdown -eq 1) {
        # Online
        winget install --id $app_wgname
    } else {
        # Download
        if (-Not (Test-Path -Path $dir_installer)) {
            $url = Get-URL-FromWinget $app_wgname "a64x64"
            Downloa-Installe $url $dir_installer
        }
        if ($mode_onoffdown -ne 3) {
            # Offline
            Instal-Ap $dir_installer $install_args
        }
    }

    Write-Host ""

}
# 
# clear param
# Remove-Variable path_file_shortcut
# 
# done

# Visual C++ 2012 x64
# 
# param
$app_num = 64
$app_shortname = "VCPP2012"
$app_toinclude = (Get-Variable -Name $("app_toinclude_" + $app_shortname)).Value
$app_wgname = "Microsoft.VCRedist.2012.x64"
$dir_installer = $app_shortname + "_" + $arch_name
$install_args = "`/passive `/norestart"
# 
# main Install/Download/Execute
if (($app_num -in $appnum_toinstall_from..$appnum_toinstall_to) -and ($app_toinclude -eq 1)) {

    if ($false) {
    # if ($mode_onoffdown -eq 1) {
        # Online
        winget install --id $app_wgname
    } else {
        # Download
        if (-Not (Test-Path -Path $dir_installer)) {
            $url = Get-URL-FromWinget $app_wgname "a64x64"
            Downloa-Installe $url $dir_installer
        }
        if ($mode_onoffdown -ne 3) {
            # Offline
            Instal-Ap $dir_installer $install_args
        }
    }

    Write-Host ""

}
# 
# clear param
# Remove-Variable path_file_shortcut
# 
# done

# Visual C++ 2013 x86
# 
# param
$app_num = 65
$app_shortname = "VCPP2013"
$app_toinclude = (Get-Variable -Name $("app_toinclude_" + $app_shortname)).Value
$app_wgname = "Microsoft.VCRedist.2013.x86"
$dir_installer = $app_shortname + "_" + "x86"
$install_args = "`/passive `/norestart"
# 
# main Install/Download/Execute
if (($app_num -in $appnum_toinstall_from..$appnum_toinstall_to) -and ($app_toinclude -eq 1)) {

    if ($false) {
    # if ($mode_onoffdown -eq 1) {
        # Online
        winget install --id $app_wgname
    } else {
        # Download
        if (-Not (Test-Path -Path $dir_installer)) {
            $url = Get-URL-FromWinget $app_wgname "a64x64"
            Downloa-Installe $url $dir_installer
        }
        if ($mode_onoffdown -ne 3) {
            # Offline
            Instal-Ap $dir_installer $install_args
        }
    }

    Write-Host ""

}
# 
# clear param
# Remove-Variable path_file_shortcut
# 
# done

# Visual C++ 2013 x64
# 
# param
$app_num = 65
$app_shortname = "VCPP2013"
$app_toinclude = (Get-Variable -Name $("app_toinclude_" + $app_shortname)).Value
$app_wgname = "Microsoft.VCRedist.2013.x64"
$dir_installer = $app_shortname + "_" + $arch_name
$install_args = "`/passive `/norestart"
# 
# main Install/Download/Execute
if (($app_num -in $appnum_toinstall_from..$appnum_toinstall_to) -and ($app_toinclude -eq 1)) {

    if ($false) {
    # if ($mode_onoffdown -eq 1) {
        # Online
        winget install --id $app_wgname
    } else {
        # Download
        if (-Not (Test-Path -Path $dir_installer)) {
            $url = Get-URL-FromWinget $app_wgname "a64x64"
            Downloa-Installe $url $dir_installer
        }
        if ($mode_onoffdown -ne 3) {
            # Offline
            Instal-Ap $dir_installer $install_args
        }
    }

    Write-Host ""

}
# 
# clear param
# Remove-Variable path_file_shortcut
# 
# done

# Visual C++ 2015+ x86
# 
# param
$app_num = 66
$app_shortname = "VCPP2015plus"
$app_toinclude = (Get-Variable -Name $("app_toinclude_" + $app_shortname)).Value
$app_wgname = "Microsoft.VCRedist.2015+.x86"
$dir_installer = $app_shortname + "_" + "x86"
$install_args = "`/passive `/norestart"
# 
# main Install/Download/Execute
if (($app_num -in $appnum_toinstall_from..$appnum_toinstall_to) -and ($app_toinclude -eq 1)) {

    if ($false) {
    # if ($mode_onoffdown -eq 1) {
        # Online
        winget install --id $app_wgname
    } else {
        # Download
        if (-Not (Test-Path -Path $dir_installer)) {
            $url = Get-URL-FromWinget $app_wgname "a64x64"
            Downloa-Installe $url $dir_installer
        }
        if ($mode_onoffdown -ne 3) {
            # Offline
            Instal-Ap $dir_installer $install_args
        }
    }

    Write-Host ""

}
# 
# clear param
# Remove-Variable path_file_shortcut
# 
# done

# Visual C++ 2015+ x64
# 
# param
$app_num = 66
$app_shortname = "VCPP2015plus"
$app_toinclude = (Get-Variable -Name $("app_toinclude_" + $app_shortname)).Value
$app_wgname = "Microsoft.VCRedist.2015+.x64"
$dir_installer = $app_shortname + "_" + $arch_name
$install_args = "`/passive `/norestart"
# 
# main Install/Download/Execute
if (($app_num -in $appnum_toinstall_from..$appnum_toinstall_to) -and ($app_toinclude -eq 1)) {

    if ($false) {
    # if ($mode_onoffdown -eq 1) {
        # Online
        winget install --id $app_wgname
    } else {
        # Download
        if (-Not (Test-Path -Path $dir_installer)) {
            $url = Get-URL-FromWinget $app_wgname "a64x64"
            Downloa-Installe $url $dir_installer
        }
        if ($mode_onoffdown -ne 3) {
            # Offline
            Instal-Ap $dir_installer $install_args
        }
    }

    Write-Host ""

}
# 
# clear param
# Remove-Variable path_file_shortcut
# 
# done

# Visual C++ 14 x86
# 
# param
$app_num = 67
$app_shortname = "VCPP14"
$app_toinclude = (Get-Variable -Name $("app_toinclude_" + $app_shortname)).Value
$app_wgname = "Microsoft.VCRedist.14.x86"
$url_appspecific = $url_VCPP14_x86
$dir_installer = $app_shortname + "_" + "x86"
$install_args = "`/passive `/norestart"
# 
# main Install/Download/Execute
if (($app_num -in $appnum_toinstall_from..$appnum_toinstall_to) -and ($app_toinclude -eq 1)) {

    if ($false) {
    # if ($mode_onoffdown -eq 1) {
        # Online
        winget install --id $app_wgname
    } else {
        # Download
        if (-Not (Test-Path -Path $dir_installer)) {
            # $url = Get-URL-FromWinget $app_wgname "a64x64"
            $url = $url_appspecific
            Downloa-Installe $url $dir_installer
        }
        if ($mode_onoffdown -ne 3) {
            # Offline
            Instal-Ap $dir_installer $install_args
        }
    }

    Write-Host ""

}
# 
# clear param
# Remove-Variable path_file_shortcut
# 
# done

# Visual C++ 14 x64
# 
# param
$app_num = 67
$app_shortname = "VCPP14"
$app_toinclude = (Get-Variable -Name $("app_toinclude_" + $app_shortname)).Value
$app_wgname = "Microsoft.VCRedist.14.x64"
$url_appspecific = $url_VCPP14_x64
$dir_installer = $app_shortname + "_" + $arch_name
$install_args = "`/passive `/norestart"
# 
# main Install/Download/Execute
if (($app_num -in $appnum_toinstall_from..$appnum_toinstall_to) -and ($app_toinclude -eq 1)) {

    if ($false) {
    # if ($mode_onoffdown -eq 1) {
        # Online
        winget install --id $app_wgname
    } else {
        # Download
        if (-Not (Test-Path -Path $dir_installer)) {
            # $url = Get-URL-FromWinget $app_wgname "a64x64"
            $url = $url_appspecific
            Downloa-Installe $url $dir_installer
        }
        if ($mode_onoffdown -ne 3) {
            # Offline
            Instal-Ap $dir_installer $install_args
        }
    }

    Write-Host ""

}
# 
# clear param
# Remove-Variable path_file_shortcut
# 
# done

# C++ Desktop Bridge 11
# 
# param
$app_num = 71
$app_shortname = "CPPDB11"
$app_toinclude = (Get-Variable -Name $("app_toinclude_" + $app_shortname)).Value
$url_appspecific = $url_CPPDB11
$dir_installer = $app_shortname + "_" + "x86"
$install_args = "`/passive `/norestart"
# 
# main Install/Download/Execute
if (($app_num -in $appnum_toinstall_from..$appnum_toinstall_to) -and ($app_toinclude -eq 1)) {

    # Download
    if (-Not (Test-Path -Path $dir_installer)) {
        $url = $url_appspecific
        Downloa-Installe $url $dir_installer
    }
    if ($mode_onoffdown -ne 3) {
        # Offline
        Instal-Ap $dir_installer $install_args
    }

    Write-Host ""

}
# 
# clear param
# Remove-Variable path_file_shortcut
# 
# done

# C++ Desktop Bridge 12
# 
# param
$app_num = 72
$app_shortname = "CPPDB12"
$app_toinclude = (Get-Variable -Name $("app_toinclude_" + $app_shortname)).Value
$url_appspecific = $url_CPPDB12
$dir_installer = $app_shortname + "_" + "x86"
$install_args = "`/passive `/norestart"
# 
# main Install/Download/Execute
if (($app_num -in $appnum_toinstall_from..$appnum_toinstall_to) -and ($app_toinclude -eq 1)) {

    # Download
    if (-Not (Test-Path -Path $dir_installer)) {
        $url = $url_appspecific
        Downloa-Installe $url $dir_installer
    }
    if ($mode_onoffdown -ne 3) {
        # Offline
        Instal-Ap $dir_installer $install_args
    }

    Write-Host ""

}
# 
# clear param
# Remove-Variable path_file_shortcut
# 
# done

# Python 3
# 
# param
$app_num = 81
$app_shortname = "Python3"
$app_toinclude = (Get-Variable -Name $("app_toinclude_" + $app_shortname)).Value
$app_wgname = "Python.Python.3.14"
$dir_installer = $app_shortname + "_" + $arch_name
$install_args = "`/passive InstallAllUsers=1 PrependPath=1"
# 
# main Install/Download/Execute
if (($app_num -in $appnum_toinstall_from..$appnum_toinstall_to) -and ($app_toinclude -eq 1)) {

    if ($mode_onoffdown -eq 1) {
        # Online
        winget install --id $app_wgname -a $arch_name
    } else {
        # Download
        if (-Not (Test-Path -Path $dir_installer)) {
            $url = Get-URL-FromWinget $app_wgname $arch_name
            Downloa-Installe $url $dir_installer
        }
        if ($mode_onoffdown -ne 3) {
            # Offline
            Instal-Ap $dir_installer $install_args
        }
    }

    Write-Host ""

}
# 
# clear param
# Remove-Variable path_file_shortcut
# 
# done

# Python 2
# 
# param
$app_num = 82
$app_shortname = "Python2"
$app_toinclude = (Get-Variable -Name $("app_toinclude_" + $app_shortname)).Value
$app_wgname = "Python.Python.2"
$dir_installer = $app_shortname + "_" + $arch_name
$install_args = "`/passive `/norestart ADDLOCAL=ALL"
# 
# main Install/Download/Execute
if (($app_num -in $appnum_toinstall_from..$appnum_toinstall_to) -and ($app_toinclude -eq 1)) {

    if ($mode_onoffdown -eq 1) {
        # Online
        winget install --id $app_wgname -a $arch_name
    } else {
        # Download
        if (-Not (Test-Path -Path $dir_installer)) {
            $url = Get-URL-FromWinget $app_wgname $arch_name
            Downloa-Installe $url $dir_installer
        }
        if ($mode_onoffdown -ne 3) {
            # Offline
            Instal-Ap $dir_installer $install_args
        }
    }

    Write-Host ""

}
# 
# clear param
# Remove-Variable path_file_shortcut
# 
# done

# Sublime Text
# 
# param
$app_num = 91
$app_shortname = "SublimeText"
$app_toinclude = (Get-Variable -Name $("app_toinclude_" + $app_shortname)).Value
$app_wgname = "SublimeHQ.SublimeText.4"
$dir_installer = $app_shortname + "_" + $arch_name
$install_args = "`/SILENT"
$path_file_shortcut = "$dir_startmenuprograms_allusers\Sublime Text.lnk"
# 
# main Install/Download/Execute
if (($app_num -in $appnum_toinstall_from..$appnum_toinstall_to) -and ($app_toinclude -eq 1)) {

    if ($false) {
    # if ($mode_onoffdown -eq 1) {
        # Online
        winget install --id $app_wgname -a $arch_name
    } else {
        # Download
        if (-Not (Test-Path -Path $dir_installer)) {
            $url = Get-URL-FromWinget $app_wgname $arch_name
            Downloa-Installe $url $dir_installer
        }
        if ($mode_onoffdown -ne 3) {
            # Offline
            Instal-Ap $dir_installer $install_args
        }
    }
    # copy shortcut
    if (Test-Path -Path $path_file_shortcut) {
        Copy-Item -Path $path_file_shortcut -Destination "$dir_desktop_allusers" -Force
    }

    Write-Host ""

}
# 
# clear param
Remove-Variable path_file_shortcut
# 
# done

# Restart
# 
# param
$app_num = 100
$app_shortname = "RestartMidway"
$app_toinclude = (Get-Variable -Name $("app_toinclude_" + $app_shortname)).Value
# 
# main Install/Download/Execute
if (($app_num -in $appnum_toinstall_from..$appnum_toinstall_to) -and ($app_toinclude -eq 1)) {
    if ($mode_onoffdown -ne 3) {
        # Restart
        Restart-Computer -Force
    }
}
# 
# clear param
# Remove-Variable path_file_shortcut
# 
# done

# Microsoft PowerShell
# 
# param
$app_num = 101
$app_shortname = "PowerShell"
$app_toinclude = (Get-Variable -Name $("app_toinclude_" + $app_shortname)).Value
$app_wgname = "Microsoft.PowerShell"
$dir_installer = $app_shortname + "_" + "a64x64"
$install_args = "`/passive"
$path_file_shortcut = "$dir_startmenuprograms_allusers\PowerShell\PowerShell 7 (x64).lnk"
# 
# main Install/Download/Execute
if (($app_num -in $appnum_toinstall_from..$appnum_toinstall_to) -and ($app_toinclude -eq 1)) {

    if ($mode_onoffdown -eq 1) {
        # Online
        winget install --id $app_wgname
    } else {
        # Download
        if (-Not (Test-Path -Path $dir_installer)) {
            $url = Get-URL-FromWinget $app_wgname "a64x64"
            Downloa-Installe $url $dir_installer
        }
        if ($mode_onoffdown -ne 3) {
            # Offline
            Instal-Ap $dir_installer $install_args
        }
    }
    # copy shortcut
    if (Test-Path -Path $path_file_shortcut) {
        Copy-Item -Path $path_file_shortcut -Destination "$dir_desktop_allusers" -Force
    }

    Write-Host ""

}
# 
# clear param
Remove-Variable path_file_shortcut
# 
# done

# Microsoft Windows Terminal
# 
# param
$app_num = 102
$app_shortname = "WinTerminal"
$app_toinclude = (Get-Variable -Name $("app_toinclude_" + $app_shortname)).Value
$app_wgname = "Microsoft.WindowsTerminal"
$dir_installer = $app_shortname + "_" + "a64x64"
$install_args = ""
# 
# main Install/Download/Execute
if (($app_num -in $appnum_toinstall_from..$appnum_toinstall_to) -and ($app_toinclude -eq 1)) {

    if ($mode_onoffdown -eq 1) {
        # Online
        winget install --id $app_wgname
    } else {
        # Download
        if (-Not (Test-Path -Path $dir_installer)) {
            $url = Get-URL-FromWinget $app_wgname "a64x64"
            Downloa-Installe $url $dir_installer
        }
        if ($mode_onoffdown -ne 3) {
            # Offline
            Instal-Ap $dir_installer $install_args
        }
    }

    Write-Host ""

}
# 
# clear param
# Remove-Variable path_file_shortcut
# 
# done

# Microsoft Visual Studio Code
# 
# param
$app_num = 103
$app_shortname = "VSCode"
$app_toinclude = (Get-Variable -Name $("app_toinclude_" + $app_shortname)).Value
$app_wgname = "Microsoft.VisualStudioCode"
if ($arch_name -eq "arm64") {
    $url_appspecific = $url_VSCode_a64
} else {
    $url_appspecific = $url_VSCode_x64
}
$dir_installer = $app_shortname + "_" + $arch_name
$install_args = "`/SILENT `/NORESTART `/MERGETASKS=!runcode"
$path_file_shortcut = "$dir_startmenuprograms_allusers\Visual Studio Code\Visual Studio Code.lnk"
# 
# main Install/Download/Execute
if (($app_num -in $appnum_toinstall_from..$appnum_toinstall_to) -and ($app_toinclude -eq 1)) {

    if ($false) {
    # if ($mode_onoffdown -eq 1) {
        # Online
        winget install --id $app_wgname -a $arch_name
    } else {
        # Download
        if (-Not (Test-Path -Path $dir_installer)) {
            $url = $url_appspecific
            Downloa-Installe $url $dir_installer
            Get-ChildItem -Path $dir_installer | Rename-Item -NewName "VSCodeSetup-_ver_$arch_name.exe"
        }
        if ($mode_onoffdown -ne 3) {
            # Offline
            Instal-Ap $dir_installer $install_args
        }
    }
    # copy shortcut
    if (Test-Path -Path $path_file_shortcut) {
        Copy-Item -Path $path_file_shortcut -Destination "$dir_desktop_allusers" -Force
    }

    Write-Host ""

}
# 
# clear param
Remove-Variable path_file_shortcut
# 
# done

# Microsoft Windows Subsystem for Linux
# 
# param
$app_num = 104
$app_shortname = "WSL"
$app_toinclude = (Get-Variable -Name $("app_toinclude_" + $app_shortname)).Value
# 
# main Install/Download/Execute
if (($app_num -in $appnum_toinstall_from..$appnum_toinstall_to) -and ($app_toinclude -eq 1)) {


    # set wsl2 as default
    wsl --set-default-version 2


    # Linux Distro
    # 
    # param
    $app_shortname = "Ubuntu2404"
    $app_wgname = "Canonical.Ubuntu.2404"
    $dir_installer = $app_shortname + "_" + "a64x64"
    $install_args = ""
    # 
    # main Install/Download/Execute
    if ($mode_onoffdown -eq 1) {
        # Online
        winget install --id $app_wgname
    } else {
        # Download
        if (-Not (Test-Path -Path $dir_installer)) {
            $url = Get-URL-FromWinget $app_wgname "a64x64"
            Downloa-Installe $url $dir_installer
        }
        if ($mode_onoffdown -ne 3) {
            # Offline
            Instal-Ap $dir_installer $install_args
        }
    }


    # Initialise
    # ubuntu2004.exe


    Write-Host ""


}
# 
# clear param
# Remove-Variable path_file_shortcut
# 
# done

# Apple iTunes
# 
# param
$app_num = 111
$app_shortname = "iTunes"
$app_toinclude = (Get-Variable -Name $("app_toinclude_" + $app_shortname)).Value
$app_wgname = "Apple.iTunes"
$dir_installer = $app_shortname + "_" + $arch_name
$install_args = "`/qn `/norestart"
# 
# main Install/Download/Execute
if (($app_num -in $appnum_toinstall_from..$appnum_toinstall_to) -and ($app_toinclude -eq 1)) {

    if ($mode_onoffdown -eq 1) {
        # Online
        winget install --id $app_wgname -a $arch_name
    } else {
        # Download
        if (-Not (Test-Path -Path $dir_installer)) {
            $url = Get-URL-FromWinget $app_wgname $arch_name
            Downloa-Installe $url $dir_installer
        }
        if ($mode_onoffdown -ne 3) {
            # Offline
            Instal-Ap $dir_installer $install_args
        }
    }

    Write-Host ""

}
# 
# clear param
# Remove-Variable path_file_shortcut
# 
# done

# Microsoft Edge
# 
# param
$app_num = 121
$app_shortname = "Edge"
$app_toinclude = (Get-Variable -Name $("app_toinclude_" + $app_shortname)).Value
$app_wgname = "Microsoft.Edge"
$dir_installer = $app_shortname + "_" + $arch_name
$install_args = "`/passive"
$path_file_shortcut = "$dir_startmenuprograms_allusers\Microsoft Edge.lnk"
# 
# main Install/Download/Execute
if (($app_num -in $appnum_toinstall_from..$appnum_toinstall_to) -and ($app_toinclude -eq 1)) {

    if ($false) {
    # if ($mode_onoffdown -eq 1) {
        # Online
        winget install --id $app_wgname -a $arch_name
    } else {
        # Download
        if (-Not (Test-Path -Path $dir_installer)) {
            $url = Get-URL-FromWinget $app_wgname $arch_name
            Downloa-Installe $url $dir_installer
        }
        if ($mode_onoffdown -ne 3) {
            # Offline
            Instal-Ap $dir_installer $install_args
        }
    }
    # copy shortcut
    # if (Test-Path -Path $path_file_shortcut) {
        # Copy-Item -Path $path_file_shortcut -Destination "$dir_desktop_allusers" -Force
    # }

    Write-Host ""

}
# 
# clear param
Remove-Variable path_file_shortcut
# 
# done

# Microsoft Teams
# 
# param
$app_num = 122
$app_shortname = "Teams"
$app_toinclude = (Get-Variable -Name $("app_toinclude_" + $app_shortname)).Value
$app_wgname = "Microsoft.Teams"
$app_msstore_id = "XP8BT8DW290MPQ"
$dir_installer = $app_shortname + "_" + $arch_name
$install_args = "`/S"
# 
# main Install/Download/Execute
if (($app_num -in $appnum_toinstall_from..$appnum_toinstall_to) -and ($app_toinclude -eq 1)) {

    if ($mode_onoffdown -ne 3) {
        winget install --id $app_wgname
        # winget install --id $app_msstore_id --accept-source-agreements --accept-package-agreements
        Write-Host ""
    }

    # if ($mode_onoffdown -eq 1) {
    #     # Online
    #     winget install --id $app_wgname -a $arch_name
    # } else {
    #     # Download
    #     if (-Not (Test-Path -Path $dir_installer)) {
    #         $url = Get-URL-FromWinget $app_wgname $arch_name
    #         Downloa-Installe $url $dir_installer
    #     }
    #     if ($mode_onoffdown -ne 3) {
    #         # Offline
    #         Instal-Ap $dir_installer $install_args
    #     }
    # }

    # Write-Host ""

}
# 
# clear param
# Remove-Variable path_file_shortcut
# 
# done

# Microsoft Skype
# 
# param
$app_num = 123
$app_shortname = "Skype"
$app_toinclude = (Get-Variable -Name $("app_toinclude_" + $app_shortname)).Value
$app_wgname = "Microsoft.Skype"
$dir_installer = $app_shortname + "_" + "a64x64"
$install_args = "`/SILENT"
$path_file_shortcut = "$dir_startmenuprograms_allusers\Skype\Skype.lnk"
# 
# main Install/Download/Execute
if (($app_num -in $appnum_toinstall_from..$appnum_toinstall_to) -and ($app_toinclude -eq 1)) {

    if ($mode_onoffdown -eq 1) {
        # Online
        winget install --id $app_wgname
    } else {
        # Download
        if (-Not (Test-Path -Path $dir_installer)) {
            $url = Get-URL-FromWinget $app_wgname "a64x64"
            Downloa-Installe $url $dir_installer
        }
        if ($mode_onoffdown -ne 3) {
            # Offline
            Instal-Ap $dir_installer $install_args
        }
    }
    # copy shortcut
    if (Test-Path -Path $path_file_shortcut) {
        Copy-Item -Path $path_file_shortcut -Destination "$dir_desktop_allusers" -Force
    }

    Write-Host ""

}
# 
# clear param
Remove-Variable path_file_shortcut
# 
# done

# Microsoft Windows Essentials
# 
# param
$app_num = 124
$app_shortname = "WinEssentials2012"
$app_toinclude = (Get-Variable -Name $("app_toinclude_" + $app_shortname)).Value
$url_appspecific = $url_WinEssentials2012
$dir_installer = $app_shortname + "_" + "x86"
$install_args = "`/AppSelect:MovieMaker `/AppSelect:Mail `/silent `/noceip `/nohomepage `/nolaunch `/nomu `/nosearch `/notoolbarceip"
$path_file_shortcut = "$dir_startmenuprograms_allusers\Movie Maker.lnk"
# 
# main Install/Download/Execute
if (($app_num -in $appnum_toinstall_from..$appnum_toinstall_to) -and ($app_toinclude -eq 1)) {

    # Download
    if (-Not (Test-Path -Path $dir_installer)) {
        $url = $url_appspecific
        Downloa-Installe $url $dir_installer
    }
    if ($mode_onoffdown -ne 3) {
        # Offline
        Instal-Ap $dir_installer $install_args
    }
    # copy shortcut
    if (Test-Path -Path $path_file_shortcut) {
        Copy-Item -Path $path_file_shortcut -Destination "$dir_desktop_allusers" -Force
    }
    # 
    # copy other shortcuts
    # 
    # photo gallery
    $path_file_shortcut = "$dir_startmenuprograms_allusers\Photo Gallery.lnk"
    if (Test-Path -Path $path_file_shortcut) {
        Copy-Item -Path $path_file_shortcut -Destination "$dir_desktop_allusers" -Force
    }
    # 
    # windows live mail
    # $path_file_shortcut = "$dir_startmenuprograms_allusers\Windows Live Mail.lnk"
    # if (Test-Path -Path $path_file_shortcut) {
        # Copy-Item -Path $path_file_shortcut -Destination "$dir_desktop_allusers" -Force
    # }
    # 
    # windows live messenger
    # $path_file_shortcut = "$dir_startmenuprograms_allusers\Windows Live Messenger.lnk"
    # if (Test-Path -Path $path_file_shortcut) {
        # Copy-Item -Path $path_file_shortcut -Destination "$dir_desktop_allusers" -Force
    # }
    # 
    # windows live writer
    # $path_file_shortcut = "$dir_startmenuprograms_allusers\Windows Live\Windows Live Writer.lnk"
    # if (Test-Path -Path $path_file_shortcut) {
        # Copy-Item -Path $path_file_shortcut -Destination "$dir_desktop_allusers" -Force
    # }

    Write-Host ""

}
# 
# clear param
Remove-Variable path_file_shortcut
# 
# done

# Google Chrome
# 
# param
$app_num = 131
$app_shortname = "Chrome"
$app_toinclude = (Get-Variable -Name $("app_toinclude_" + $app_shortname)).Value
$app_wgname = "Google.Chrome"
$dir_installer = $app_shortname + "_" + $arch_name
$install_args = "`/passive"
$path_file_shortcut = "$dir_startmenuprograms_allusers\Google Chrome.lnk"
# 
# main Install/Download/Execute
if (($app_num -in $appnum_toinstall_from..$appnum_toinstall_to) -and ($app_toinclude -eq 1)) {

    if ($false) {
    # if ($mode_onoffdown -eq 1) {
        # Online
        winget install --id $app_wgname -a $arch_name
    } else {
        # Download
        if (-Not (Test-Path -Path $dir_installer)) {
            $url = Get-URL-FromWinget $app_wgname $arch_name
            Downloa-Installe $url $dir_installer
        }
        if ($mode_onoffdown -ne 3) {
            # Offline
            Instal-Ap $dir_installer $install_args
        }
    }
    # copy shortcut
    if (Test-Path -Path $path_file_shortcut) {
        Copy-Item -Path $path_file_shortcut -Destination "$dir_desktop_allusers" -Force
    }

    Write-Host ""

}
# 
# clear param
Remove-Variable path_file_shortcut
# 
# done

# Google Drive
# 
# param
$app_num = 132
$app_shortname = "Drive"
$app_toinclude = (Get-Variable -Name $("app_toinclude_" + $app_shortname)).Value
$app_wgname = "Google.GoogleDrive"
$dir_installer = $app_shortname + "_" + "a64x64"
$install_args = "--silent"
$path_file_shortcut = "$dir_startmenuprograms_allusers\Google Drive.lnk"
# 
# main Install/Download/Execute
if (($app_num -in $appnum_toinstall_from..$appnum_toinstall_to) -and ($app_toinclude -eq 1)) {

    if ($mode_onoffdown -eq 1) {
        # Online
        winget install --id $app_wgname
    } else {
        # Download
        if (-Not (Test-Path -Path $dir_installer)) {
            $url = Get-URL-FromWinget $app_wgname "a64x64"
            Downloa-Installe $url $dir_installer
        }
        if ($mode_onoffdown -ne 3) {
            # Offline
            Instal-Ap $dir_installer $install_args
        }
    }
    # copy shortcut
    if (Test-Path -Path $path_file_shortcut) {
        Copy-Item -Path $path_file_shortcut -Destination "$dir_desktop_allusers" -Force
    }

    Write-Host ""

}
# 
# clear param
Remove-Variable path_file_shortcut
# 
# done

# Meta Messenger
# 
# param
$app_num = 141
$app_shortname = "Messenger"
$app_toinclude = (Get-Variable -Name $("app_toinclude_" + $app_shortname)).Value
$app_wgname = "Meta.Messenger"
$app_msstore_id = "9WZDNCRF0083"
$dir_installer = $app_shortname + "_" + $arch_name
$install_args = "`/passive"
# 
# main Install/Download/Execute
if (($app_num -in $appnum_toinstall_from..$appnum_toinstall_to) -and ($app_toinclude -eq 1)) {

    if ($mode_onoffdown -ne 3) {
        winget install --id $app_msstore_id --accept-source-agreements --accept-package-agreements
        Write-Host ""
    }

    Write-Host ""

}
# 
# clear param
# Remove-Variable path_file_shortcut
# 
# done

# Adobe Acrobat Reader
# 
# param
$app_num = 151
$app_shortname = "AcrobatReader"
$app_toinclude = (Get-Variable -Name $("app_toinclude_" + $app_shortname)).Value
if ($arch_name -eq "x64") {
    $app_wgname = "Adobe.Acrobat.Reader.64-bit"
} else {
    $app_wgname = "Adobe.Acrobat.Reader.32-bit"
}
$dir_installer = $app_shortname + "_" + $arch_name
$install_args = "`/sPB `/rs"
$path_file_shortcut = "$dir_startmenuprograms_allusers\Adobe Acrobat.lnk"
# note for Acrobat XI it is "$dir_startmenuprograms_allusers\Adobe Acrobat XI Pro.lnk"
# 
# main Install/Download/Execute
if (($app_num -in $appnum_toinstall_from..$appnum_toinstall_to) -and ($app_toinclude -eq 1)) {

    # if ($false) {
    if ($mode_onoffdown -eq 1) {
        # Online
        winget install --id $app_wgname
    } else {
        # Download
        if (-Not (Test-Path -Path $dir_installer)) {
            $url = Get-URL-FromWinget $app_wgname "a64x64"
            Downloa-Installe $url $dir_installer
        }
        if ($mode_onoffdown -ne 3) {
            # Offline
            Instal-Ap $dir_installer $install_args
        }
    }
    # copy shortcut
    if (Test-Path -Path $path_file_shortcut) {
        Copy-Item -Path $path_file_shortcut -Destination "$dir_desktop_allusers" -Force
    }

    Write-Host ""

}
# 
# clear param
Remove-Variable path_file_shortcut
# 
# done

# Dropbox
# 
# param
$app_num = 161
$app_shortname = "Dropbox"
$app_toinclude = (Get-Variable -Name $("app_toinclude_" + $app_shortname)).Value
$app_wgname = "Dropbox.Dropbox"
$dir_installer = $app_shortname + "_" + $arch_name
$install_args = "`/NOLAUNCH"
$path_file_shortcut = "$dir_startmenuprograms_allusers\Dropbox\Dropbox.lnk"
# 
# main Install/Download/Execute
if (($app_num -in $appnum_toinstall_from..$appnum_toinstall_to) -and ($app_toinclude -eq 1)) {

    if ($mode_onoffdown -eq 1) {
        # Online
        winget install --id $app_wgname -a $arch_name
    } else {
        # Download
        if (-Not (Test-Path -Path $dir_installer)) {
            $url = Get-URL-FromWinget $app_wgname $arch_name
            Downloa-Installe $url $dir_installer
        }
        if ($mode_onoffdown -ne 3) {
            # Offline
            Instal-Ap $dir_installer $install_args
        }
    }
    # copy shortcut
    if (Test-Path -Path $path_file_shortcut) {
        Copy-Item -Path $path_file_shortcut -Destination "$dir_desktop_allusers" -Force
    }

    Write-Host ""

}
# 
# clear param
Remove-Variable path_file_shortcut
# 
# done

# Zoom
# 
# param
$app_num = 171
$app_shortname = "Zoom"
$app_toinclude = (Get-Variable -Name $("app_toinclude_" + $app_shortname)).Value
$app_wgname = "Zoom.Zoom"
$dir_installer = $app_shortname + "_" + $arch_name
$install_args = "`/passive ZoomAutoUpdate='true'"
$path_file_shortcut = "$dir_startmenuprograms_allusers\Zoom\Zoom Workplace.lnk"
# 
# main Install/Download/Execute
if (($app_num -in $appnum_toinstall_from..$appnum_toinstall_to) -and ($app_toinclude -eq 1)) {

    if ($mode_onoffdown -eq 1) {
        # Online
        winget install --id $app_wgname -a $arch_name
    } else {
        # Download
        if (-Not (Test-Path -Path $dir_installer)) {
            $url = Get-URL-FromWinget $app_wgname $arch_name
            Downloa-Installe $url $dir_installer
        }
        if ($mode_onoffdown -ne 3) {
            # Offline
            Instal-Ap $dir_installer $install_args
        }
    }
    # copy shortcut
    if (Test-Path -Path $path_file_shortcut) {
        Copy-Item -Path $path_file_shortcut -Destination "$dir_desktop_allusers" -Force
    }

    Write-Host ""

}
# 
# clear param
Remove-Variable path_file_shortcut
# 
# done

# Discord
# 
# param
$app_num = 172
$app_shortname = "Discord"
$app_toinclude = (Get-Variable -Name $("app_toinclude_" + $app_shortname)).Value
$app_wgname = "Discord.Discord"
$dir_installer = $app_shortname + "_" + $arch_name
$install_args = "-s"
$path_file_shortcut = "$dir_startmenuprograms_currentuser\Discord Inc\Discord.lnk"
# 
# main Install/Download/Execute
if (($app_num -in $appnum_toinstall_from..$appnum_toinstall_to) -and ($app_toinclude -eq 1)) {

    if ($mode_onoffdown -eq 1) {
        # Online
        winget install --id $app_wgname -a $arch_name
    } else {
        # Download
        if (-Not (Test-Path -Path $dir_installer)) {
            $url = Get-URL-FromWinget $app_wgname $arch_name
            Downloa-Installe $url $dir_installer
        }
        if ($mode_onoffdown -ne 3) {
            # Offline
            Instal-Ap $dir_installer $install_args
        }
    }
    # copy shortcut
    if (Test-Path -Path $path_file_shortcut) {
        Copy-Item -Path $path_file_shortcut -Destination "$dir_desktop_currentuser" -Force
    }

    Write-Host ""

}
# 
# clear param
Remove-Variable path_file_shortcut
# 
# done

# Telegram
# 
# param
$app_num = 173
$app_shortname = "Telegram"
$app_toinclude = (Get-Variable -Name $("app_toinclude_" + $app_shortname)).Value
$app_wgname = "Telegram.TelegramDesktop"
$dir_installer = $app_shortname + "_" + $arch_name
$install_args = "`/SILENT `/NORESTART"
$path_file_shortcut = "$dir_startmenuprograms_currentuser\Telegram Desktop\Telegram.lnk"
# 
# main Install/Download/Execute
if (($app_num -in $appnum_toinstall_from..$appnum_toinstall_to) -and ($app_toinclude -eq 1)) {

    if ($mode_onoffdown -eq 1) {
        # Online
        winget install --id $app_wgname -a $arch_name
    } else {
        # Download
        if (-Not (Test-Path -Path $dir_installer)) {
            $url = Get-URL-FromWinget $app_wgname $arch_name
            Downloa-Installe $url $dir_installer
        }
        if ($mode_onoffdown -ne 3) {
            # Offline
            Instal-Ap $dir_installer $install_args
        }
    }
    # copy shortcut
    if (Test-Path -Path $path_file_shortcut) {
        Copy-Item -Path $path_file_shortcut -Destination "$dir_desktop_currentuser" -Force
    }

    Write-Host ""

}
# 
# clear param
Remove-Variable path_file_shortcut
# 
# done

# WhatsApp
# 
# param
$app_num = 174
$app_shortname = "WhatsApp"
$app_toinclude = (Get-Variable -Name $("app_toinclude_" + $app_shortname)).Value
$app_wgname = "WhatsApp.WhatsApp"
$app_msstore_id = "9NKSQGP7F2NH"
$dir_installer = $app_shortname + "_" + $arch_name
$install_args = "--silent"
# 
# main Install/Download/Execute
if (($app_num -in $appnum_toinstall_from..$appnum_toinstall_to) -and ($app_toinclude -eq 1)) {

    if ($mode_onoffdown -ne 3) {
        winget install --id $app_msstore_id --accept-source-agreements --accept-package-agreements
        Write-Host ""
    }

    # if ($mode_onoffdown -eq 1) {
    #     # Online
    #     winget install --id $app_wgname -a $arch_name
    # } else {
    #     # Download
    #     if (-Not (Test-Path -Path $dir_installer)) {
    #         $url = Get-URL-FromWinget $app_wgname $arch_name
    #         Downloa-Installe $url $dir_installer
    #     }
    #     if ($mode_onoffdown -ne 3) {
    #         # Offline
    #         Instal-Ap $dir_installer $install_args
    #     }
    # }

    # Write-Host ""

}
# 
# clear param
# Remove-Variable path_file_shortcut
# 
# done

# WeChat
# 
# param
$app_num = 175
$app_shortname = "WeChat"
$app_toinclude = (Get-Variable -Name $("app_toinclude_" + $app_shortname)).Value
$app_wgname = "Tencent.WeChat"
$dir_installer = $app_shortname + "_" + "a64x64"
$install_args = "`/S"
$path_file_shortcut = "$dir_startmenuprograms_allusers\WeChat\WeChat.lnk"
# 
# main Install/Download/Execute
if (($app_num -in $appnum_toinstall_from..$appnum_toinstall_to) -and ($app_toinclude -eq 1)) {

    if ($mode_onoffdown -eq 1) {
        # Online
        winget install --id $app_wgname
    } else {
        # Download
        if (-Not (Test-Path -Path $dir_installer)) {
            $url = Get-URL-FromWinget $app_wgname "a64x64"
            Downloa-Installe $url $dir_installer
        }
        if ($mode_onoffdown -ne 3) {
            # Offline
            Instal-Ap $dir_installer $install_args
        }
    }
    # copy shortcut
    if (Test-Path -Path $path_file_shortcut) {
        Copy-Item -Path $path_file_shortcut -Destination "$dir_desktop_allusers" -Force
    }

    Write-Host ""

}
# 
# clear param
Remove-Variable path_file_shortcut
# 
# done

# TeamViewer Latest
# 
# param
$app_num = 181
$app_shortname = "TeamViewerLatest"
$app_toinclude = (Get-Variable -Name $("app_toinclude_" + $app_shortname)).Value
$app_wgname = "TeamViewer.TeamViewer"
$dir_installer = $app_shortname + "_" + $arch_name
$install_args = "`/S"
$path_file_shortcut = "$dir_startmenuprograms_allusers\TeamViewer.lnk"
# 
# main Install/Download/Execute
if (($app_num -in $appnum_toinstall_from..$appnum_toinstall_to) -and ($app_toinclude -eq 1)) {

    if ($mode_onoffdown -eq 1) {
        # Online
        winget install --id $app_wgname -a $arch_name
    } else {
        # Download
        if (-Not (Test-Path -Path $dir_installer)) {
            $url = Get-URL-FromWinget $app_wgname $arch_name
            Downloa-Installe $url $dir_installer
        }
        if ($mode_onoffdown -ne 3) {
            # Offline
            Instal-Ap $dir_installer $install_args
        }
    }
    # copy shortcut
    if (Test-Path -Path $path_file_shortcut) {
        Copy-Item -Path $path_file_shortcut -Destination "$dir_desktop_allusers" -Force
    }

    Write-Host ""

}
# 
# clear param
Remove-Variable path_file_shortcut
# 
# done

# TeamViewer QuickSupport 13
# 
# param
$app_num = 181
$app_shortname = "TeamViewerQS13"
$app_toinclude = (Get-Variable -Name $("app_toinclude_" + $app_shortname)).Value
$url_appspecific = $url_TeamViewerQS13
$dir_installer = $app_shortname + "_" + "x86"
$path_file_shortcut = "$dir_startmenuprograms_allusers\TeamViewerQS.lnk"
# 
# main Install/Download/Execute
if (($app_num -in $appnum_toinstall_from..$appnum_toinstall_to) -and ($app_toinclude -eq 1)) {

    # Download
    if (-Not (Test-Path -Path $dir_installer)) {
        $url = $url_appspecific
        Downloa-Installe $url $dir_installer
    }

    if ($mode_onoffdown -ne 3) {

        # Copying TeamViewerQS.exe and Create Shortcut
        Write-Host "Copying TeamViewerQS.exe ..."

        # Copy exe
        $dir_destination = "C:\"
        Copy-Item -Path "$dir_installer\TeamViewerQS.exe" -Destination $dir_destination -Recurse

        # Creating TeamViewerQS.lnk
        Write-Host "Creating TeamViewerQS.lnk ..."
        $path_origfile = "C:\TeamViewerQS.exe"
        $path_lnkfile = "$dir_startmenuprograms_allusers\TeamViewerQS.lnk"
        # 
        # Create lnk file
        $shortcut = (New-Object -ComObject WScript.Shell).CreateShortcut($path_lnkfile)
        $shortcut.TargetPath = "$path_origfile"
        $shortcut.Save()
        # Make lnk file to Run as admin
        $bytes = [System.IO.File]::ReadAllBytes("$path_lnkfile")
        $bytes[0x15] = $bytes[0x15] -bor 0x20 #set byte 21 (0x15) bit 6 (0x20) ON
        [System.IO.File]::WriteAllBytes("$path_lnkfile", $bytes)

        "... Done Copying"

    }
    # copy shortcut
    if (Test-Path -Path $path_file_shortcut) {
        Copy-Item -Path $path_file_shortcut -Destination "$dir_desktop_allusers" -Force
    }

    Write-Host ""

}
# 
# clear param
Remove-Variable path_file_shortcut
# 
# done

# SevenZip
# 
# param
$app_num = 182
$app_shortname = "SevenZip"
$app_toinclude = (Get-Variable -Name $("app_toinclude_" + $app_shortname)).Value
$app_wgname = "7zip.7zip"
$dir_installer = $app_shortname + "_" + $arch_name
$install_args = "`/passive"
$path_file_shortcut = "$dir_startmenuprograms_allusers\7-Zip\7-Zip File Manager.lnk"
# 
# main Install/Download/Execute
if (($app_num -in $appnum_toinstall_from..$appnum_toinstall_to) -and ($app_toinclude -eq 1)) {

    if ($mode_onoffdown -eq 1) {
        # Online
        winget install --id $app_wgname -a $arch_name
    } else {
        # Download
        if (-Not (Test-Path -Path $dir_installer)) {
            $url = Get-URL-FromWinget $app_wgname $arch_name
            Downloa-Installe $url $dir_installer
        }
        if ($mode_onoffdown -ne 3) {
            # Offline
            Instal-Ap $dir_installer $install_args
        }
    }
    # copy shortcut
    if (Test-Path -Path $path_file_shortcut) {
        Copy-Item -Path $path_file_shortcut -Destination "$dir_desktop_allusers" -Force
    }

    Write-Host ""

}
# 
# clear param
Remove-Variable path_file_shortcut
# 
# done

# WinRAR
# 
# param
$app_num = 182
$app_shortname = "WinRAR"
$app_toinclude = (Get-Variable -Name $("app_toinclude_" + $app_shortname)).Value
$app_wgname = "RARLab.WinRAR"
$dir_installer = $app_shortname + "_" + $arch_name
$install_args = "`/S"
$path_file_shortcut = "$dir_startmenuprograms_allusers\WinRAR\WinRAR.lnk"
# 
# main Install/Download/Execute
if (($app_num -in $appnum_toinstall_from..$appnum_toinstall_to) -and ($app_toinclude -eq 1)) {

    if ($mode_onoffdown -eq 1) {
        # Online
        winget install --id $app_wgname -a $arch_name
    } else {
        # Download
        if (-Not (Test-Path -Path $dir_installer)) {
            $url = Get-URL-FromWinget $app_wgname $arch_name
            Downloa-Installe $url $dir_installer
        }
        if ($mode_onoffdown -ne 3) {
            # Offline
            Instal-Ap $dir_installer $install_args
        }
    }
    # copy shortcut
    if (Test-Path -Path $path_file_shortcut) {
        Copy-Item -Path $path_file_shortcut -Destination "$dir_desktop_allusers" -Force
    }

    Write-Host ""

}
# 
# clear param
Remove-Variable path_file_shortcut
# 
# done

# VLC
# 
# param
$app_num = 183
$app_shortname = "VLC"
$app_toinclude = (Get-Variable -Name $("app_toinclude_" + $app_shortname)).Value
$app_wgname = "VideoLAN.VLC"
$dir_installer = $app_shortname + "_" + $arch_name
$install_args = "`/S"
$path_file_shortcut = "$dir_startmenuprograms_allusers\VideoLAN\VLC media player.lnk"
# 
# main Install/Download/Execute
if (($app_num -in $appnum_toinstall_from..$appnum_toinstall_to) -and ($app_toinclude -eq 1)) {

    # slow winget download, use offline
    if ($false) {
    # if ($mode_onoffdown -eq 1) {
        # Online
        winget install --id $app_wgname -a $arch_name
    } else {
        # Download
        if (-Not (Test-Path -Path $dir_installer)) {
            $url = Get-URL-FromWinget $app_wgname $arch_name
            Downloa-Installe $url $dir_installer
        }
        if ($mode_onoffdown -ne 3) {
            # Offline
            Instal-Ap $dir_installer $install_args
        }
    }
    # copy shortcut
    if (Test-Path -Path $path_file_shortcut) {
        Copy-Item -Path $path_file_shortcut -Destination "$dir_desktop_allusers" -Force
    }

    Write-Host ""

}
# 
# clear param
Remove-Variable path_file_shortcut
# 
# done

# Java 8 x86
# 
# param
$app_num = 184
$app_shortname = "Java8"
$app_toinclude = (Get-Variable -Name $("app_toinclude_" + $app_shortname)).Value
$app_wgname = "Oracle.JavaRuntimeEnvironment"
$dir_installer = $app_shortname + "_" + "x86"
$install_args = "`/s"
# 
# main Install/Download/Execute
if (($app_num -in $appnum_toinstall_from..$appnum_toinstall_to) -and ($app_toinclude -eq 1)) {

    if ($mode_onoffdown -eq 1) {
        # Online
        winget install --id $app_wgname -a "x86"
    } else {
        # Download
        if (-Not (Test-Path -Path $dir_installer)) {
            $url = Get-URL-FromWinget $app_wgname "x86"
            Downloa-Installe $url $dir_installer
            Get-ChildItem -Path $dir_installer | Rename-Item -NewName "jre-8u_ver_-windows-i586.exe"
        }
        if ($mode_onoffdown -ne 3) {
            # Offline
            Instal-Ap $dir_installer $install_args
        }
    }

    Write-Host ""

}
# 
# clear param
# Remove-Variable path_file_shortcut
# 
# done

# Java 8 x64
# 
# param
$app_num = 184
$app_shortname = "Java8"
$app_toinclude = (Get-Variable -Name $("app_toinclude_" + $app_shortname)).Value
$app_wgname = "Oracle.JavaRuntimeEnvironment"
$dir_installer = $app_shortname + "_" + $arch_name
$install_args = "`/s"
# 
# main Install/Download/Execute
if (($app_num -in $appnum_toinstall_from..$appnum_toinstall_to) -and ($app_toinclude -eq 1)) {

    if ($false) {
    # if ($mode_onoffdown -eq 1) {
        # Online
        winget install --id $app_wgname -a $arch_name
    } else {
        # Download
        if (-Not (Test-Path -Path $dir_installer)) {
            $url = Get-URL-FromWinget $app_wgname $arch_name
            Downloa-Installe $url $dir_installer
            Get-ChildItem -Path $dir_installer | Rename-Item -NewName "jre-8u_ver_-windows-x64.exe"
        }
        if ($mode_onoffdown -ne 3) {
            # Offline
            Instal-Ap $dir_installer $install_args
        }
    }

    Write-Host ""

}
# 
# clear param
# Remove-Variable path_file_shortcut
# 
# done

# OpenVPN
# 
# param
$app_num = 185
$app_shortname = "OpenVPN"
$app_toinclude = (Get-Variable -Name $("app_toinclude_" + $app_shortname)).Value
$app_wgname = "OpenVPNTechnologies.OpenVPNConnect"
$dir_installer = $app_shortname + "_" + $arch_name
$install_args = "`/passive"
$path_file_shortcut = "$dir_startmenuprograms_allusers\OpenVPN Connect\OpenVPN Connect.lnk"
# 
# main Install/Download/Execute
if (($app_num -in $appnum_toinstall_from..$appnum_toinstall_to) -and ($app_toinclude -eq 1)) {

    if ($mode_onoffdown -eq 1) {
        # Online
        winget install --id $app_wgname -a $arch_name
    } else {
        # Download
        if (-Not (Test-Path -Path $dir_installer)) {
            $url = Get-URL-FromWinget $app_wgname $arch_name
            Downloa-Installe $url $dir_installer
        }
        if ($mode_onoffdown -ne 3) {
            # Offline
            Instal-Ap $dir_installer $install_args
        }
    }
    # copy shortcut
    if (Test-Path -Path $path_file_shortcut) {
        Copy-Item -Path $path_file_shortcut -Destination "$dir_desktop_allusers" -Force
    }

    Write-Host ""

}
# 
# clear param
Remove-Variable path_file_shortcut
# 
# done

# WireGuard
# 
# param
$app_num = 185
$app_shortname = "WireGuard"
$app_toinclude = (Get-Variable -Name $("app_toinclude_" + $app_shortname)).Value
$app_wgname = "WireGuard.WireGuard"
$dir_installer = $app_shortname + "_" + $arch_name
$install_args = "`/passive"
$path_file_shortcut = "$dir_startmenuprograms_allusers\WireGuard.lnk"
# 
# main Install/Download/Execute
if (($app_num -in $appnum_toinstall_from..$appnum_toinstall_to) -and ($app_toinclude -eq 1)) {

    if ($mode_onoffdown -eq 1) {
        # Online
        winget install --id $app_wgname -a $arch_name
    } else {
        # Download
        if (-Not (Test-Path -Path $dir_installer)) {
            $url = Get-URL-FromWinget $app_wgname $arch_name
            Downloa-Installe $url $dir_installer
        }
        if ($mode_onoffdown -ne 3) {
            # Offline
            Instal-Ap $dir_installer $install_args
        }
    }
    # copy shortcut
    if (Test-Path -Path $path_file_shortcut) {
        Copy-Item -Path $path_file_shortcut -Destination "$dir_desktop_allusers" -Force
    }

    Write-Host ""

}
# 
# clear param
Remove-Variable path_file_shortcut
# 
# done

# Firefox
# 
# param
$app_num = 186
$app_shortname = "Firefox"
$app_toinclude = (Get-Variable -Name $("app_toinclude_" + $app_shortname)).Value
$app_wgname = "Mozilla.Firefox"
$dir_installer = $app_shortname + "_" + $arch_name
$install_args = "`-ms"
$path_file_shortcut = "$dir_startmenuprograms_allusers\Firefox.lnk"
# 
# main Install/Download/Execute
if (($app_num -in $appnum_toinstall_from..$appnum_toinstall_to) -and ($app_toinclude -eq 1)) {

    if ($mode_onoffdown -eq 1) {
        # Online
        winget install --id $app_wgname -a $arch_name
    } else {
        # Download
        if (-Not (Test-Path -Path $dir_installer)) {
            $url = Get-URL-FromWinget $app_wgname $arch_name
            Downloa-Installe $url $dir_installer
        }
        if ($mode_onoffdown -ne 3) {
            # Offline
            Instal-Ap $dir_installer $install_args
        }
    }
    # copy shortcut
    if (Test-Path -Path $path_file_shortcut) {
        Copy-Item -Path $path_file_shortcut -Destination "$dir_desktop_allusers" -Force
    }

    Write-Host ""

}
# 
# clear param
Remove-Variable path_file_shortcut
# 
# done

# Thunderbird
# 
# param
$app_num = 187
$app_shortname = "Thunderbird"
$app_toinclude = (Get-Variable -Name $("app_toinclude_" + $app_shortname)).Value
$app_wgname = "Mozilla.Thunderbird"
$dir_installer = $app_shortname + "_" + $arch_name
$install_args = "`/passive"
$path_file_shortcut = "$dir_startmenuprograms_allusers\Thunderbird.lnk"
# 
# main Install/Download/Execute
if (($app_num -in $appnum_toinstall_from..$appnum_toinstall_to) -and ($app_toinclude -eq 1)) {

    if ($mode_onoffdown -eq 1) {
        # Online
        winget install --id $app_wgname -a $arch_name
    } else {
        # Download
        if (-Not (Test-Path -Path $dir_installer)) {
            $url = Get-URL-FromWinget $app_wgname $arch_name
            Downloa-Installe $url $dir_installer
        }
        if ($mode_onoffdown -ne 3) {
            # Offline
            Instal-Ap $dir_installer $install_args
        }
    }
    # copy shortcut
    if (Test-Path -Path $path_file_shortcut) {
        Copy-Item -Path $path_file_shortcut -Destination "$dir_desktop_allusers" -Force
    }

    Write-Host ""

}
# 
# clear param
Remove-Variable path_file_shortcut
# 
# done

# OBS
# 
# param
$app_num = 188
$app_shortname = "OBS"
$app_toinclude = (Get-Variable -Name $("app_toinclude_" + $app_shortname)).Value
$app_wgname = "OBSProject.OBSStudio"
$dir_installer = $app_shortname + "_" + "a64x64"
$install_args = "`/S"
$path_file_shortcut = "$dir_startmenuprograms_allusers\OBS Studio\OBS Studio (64bit).lnk"
# 
# main Install/Download/Execute
if (($app_num -in $appnum_toinstall_from..$appnum_toinstall_to) -and ($app_toinclude -eq 1)) {

    if ($mode_onoffdown -eq 1) {
        # Online
        winget install --id $app_wgname
    } else {
        # Download
        if (-Not (Test-Path -Path $dir_installer)) {
            $url = Get-URL-FromWinget $app_wgname "a64x64"
            Downloa-Installe $url $dir_installer
        }
        if ($mode_onoffdown -ne 3) {
            # Offline
            Instal-Ap $dir_installer $install_args
        }
    }
    # copy shortcut
    if (Test-Path -Path $path_file_shortcut) {
        Copy-Item -Path $path_file_shortcut -Destination "$dir_desktop_allusers" -Force
    }

    Write-Host ""

}
# 
# clear param
Remove-Variable path_file_shortcut
# 
# done

# LibreOffice
# 
# param
$app_num = 190
$app_shortname = "LibreOffice"
$app_toinclude = (Get-Variable -Name $("app_toinclude_" + $app_shortname)).Value
$app_wgname = "TheDocumentFoundation.LibreOffice"
$dir_installer = $app_shortname + "_" + "a64x64"
$install_args = "`/passive"
$path_file_shortcut = "$dir_startmenuprograms_allusers\LibreOffice\LibreOffice.lnk"
# 
# main Install/Download/Execute
if (($app_num -in $appnum_toinstall_from..$appnum_toinstall_to) -and ($app_toinclude -eq 1)) {

    if ($mode_onoffdown -eq 1) {
        # Online
        winget install --id $app_wgname -a $arch_name
    } else {
        # Download
        if (-Not (Test-Path -Path $dir_installer)) {
            $url = Get-URL-FromWinget $app_wgname $arch_name
            Downloa-Installe $url $dir_installer
        }
        if ($mode_onoffdown -ne 3) {
            # Offline
            Instal-Ap $dir_installer $install_args
        }
    }
    # copy shortcut
    if (Test-Path -Path $path_file_shortcut) {
        Copy-Item -Path $path_file_shortcut -Destination "$dir_desktop_allusers" -Force
    }

    Write-Host ""

}
# 
# clear param
Remove-Variable path_file_shortcut
# 
# done

# Microsoft Office
# 
# param
$app_num = 200
$app_shortname = "MSOffice"
$app_toinclude = (Get-Variable -Name $("app_toinclude_" + $app_shortname)).Value
# 
# main Install/Download/Execute
if (($app_num -in $appnum_toinstall_from..$appnum_toinstall_to) -and ($app_toinclude -eq 1)) {

    # Prepare

    # define locations
    # 
    # original downloaded file
    $dir_origfile_odt2016plus = "ODT2016plus"
    $dir_origfile_odt2013 = "ODT2013"
    # 
    # extracted setup.exe file
    $dir_setupexe_odt2016plus = "$env:ProgramFiles\OfficeDeploymentTool"
    if ([Environment]::Is64BitOperatingSystem) {
        $dir_setupexe_odt2013 = "${env:ProgramFiles(x86)}\Office2013DeploymentTool"
    } else {
        $dir_setupexe_odt2013 = "$env:ProgramFiles\Office2013DeploymentTool"
    }

    # if setup.exe does not exist, create empty folders
    New-Item -ItemType "directory" -Path $dir_setupexe_odt2016plus -Force | Out-Null
    if (-Not (Test-Path -Path "$dir_setupexe_odt2016plus\setup.exe")) {
        # Del
        Get-ChildItem -Path $dir_setupexe_odt2016plus -Recurse | Remove-Item -Recurse -Force
    }
    New-Item -ItemType "directory" -Path $dir_setupexe_odt2013 -Force | Out-Null
    if (-Not (Test-Path -Path "$dir_setupexe_odt2013\setup.exe")) {
        # Del
        Get-ChildItem -Path $dir_setupexe_odt2013 -Recurse | Remove-Item -Recurse -Force
    }

    # Extract ODT2016Plus
    # param
    $app_wgname = "Microsoft.OfficeDeploymentTool"
    $dir_installer = $dir_origfile_odt2016plus
    $install_args = "`/extract:`"$dir_setupexe_odt2016plus`" `/quiet"
    # 
    # notes
    # if original file does not exist,
    # use winget or manual download, then extract
    # if original file exist,
    # directly extract
    # end notes
    # 
    if (-Not (Test-Path -Path "$dir_installer")) {
        # use winget or manual download
        if ($false) {
        # if ($mode_onoffdown -eq 1) {
            # Online
            winget install --id $app_wgname
        } else {
            # Download
            if (-Not (Test-Path -Path $dir_installer)) {
                # 
                # notes
                # Winget can only get link on 64-bit Windows
                # Also, Winget link may have error, manifest not updated
                # end notes
                # 
                $url = Get-URL-FromWinget $app_wgname "a64x64"
                Downloa-Installe $url $dir_installer
                # 
                # check manually if file downloaded successfully
                Invoke-Item -Path $dir_installer
                # 
                # Ask
                while ($manual_download_odt2016 -notin @("y","n")) {
                    $manual_download_odt2016 = (Read-Host -Prompt "Enter letter - want to manually download ODT?: y , n ").ToLower()
                }
                # 
                # yes
                if ($manual_download_odt2016 -eq "y") {
                    # manually download ODT
                    Creat-NewEmpty-Folde $dir_origfile_odt2016plus
                    Write-Host "Manually download latest ODT into Downloads folder"
                    pause
                    Start-Process "https://www.microsoft.com/en-us/download/details.aspx?id=49117"
                    Write-Host "Done?"
                    pause
                    # move
                    Get-ChildItem -Path "$HOME\Downloads" -Filter officedeploymenttool*.exe | ForEach-Object { Move-Item -Path $_.FullName -Destination $dir_origfile_odt2016plus -Force }

                }
            }
            if ($false) {
            # if ($mode_onoffdown -ne 3) {
                # Offline
                Instal-Ap $dir_installer $install_args
            }
        }
    }
    # run
    Get-ChildItem -Path $dir_installer -Recurse -Filter *.exe | % { Start-Process -FilePath $_.FullName -ArgumentList $install_args -Wait }

    # Extract ODT2013
    # param
    $dir_installer = $dir_origfile_odt2013
    $install_args = "`/extract:`"$dir_setupexe_odt2013`" `/quiet"
    # Download
    if (-Not (Test-Path -Path $dir_installer)) {
        $url = $url_ODT2013
        Downloa-Installe $url $dir_installer
    }
    # Offline
    Get-ChildItem -Path $dir_installer -Recurse -Filter *.exe | % { Start-Process -FilePath $_.FullName -ArgumentList $install_args -Wait }


    # Install
    .\script-msoffice.ps1


    Write-Host ""

}
# 
# clear param
# Remove-Variable path_file_shortcut
# 
# done

Write-Host ""

# final

# stop
Stop-Process -Name "Teams*" -Force
Stop-Process -Name "GoogleDrive*" -Force
Stop-Process -Name "Dropbox*" -Force

# clear
Remov-Folde $tmp_dir
# Clear-RecycleBin -Force
Clear-PSHistory

Write-Host ""

Write-Host "Terminating script-allapps.ps1 ..."
pause


# ==================================================
# Notes
# ==================================================
