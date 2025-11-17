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
Write-Host "(2) x86_64"
Write-Host "(3) x86"
Write-Host "(4) ia64"
Write-Host "(5) ppc64"
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
        $arch_suffix = "a64"
        break
    }
    2 {
        # 2
        $arch_suffix = "x64"
        break
    }
    3 {
        # 3
        $arch_suffix = "x86"
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
$appnum_toinclude = $appnum_toinclude_WinGet
# 
# main Install/Download/Execute
if (($app_num -in $appnum_toinstall_from..$appnum_toinstall_to) -and ($appnum_toinclude -eq 1)) {
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
$appnum_toinclude = $appnum_toinclude_enableDevMode
# 
# main Install/Download/Execute
if (($app_num -in $appnum_toinstall_from..$appnum_toinstall_to) -and ($appnum_toinclude -eq 1)) {

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
$appnum_toinclude = $appnum_toinclude_wincomponentdotNET35
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
if (($app_num -in $appnum_toinstall_from..$appnum_toinstall_to) -and ($appnum_toinclude -eq 1)) {

    Write-Host "Enabling NetFx3 ..."
    if (-Not (Test-Path -Path "$dir_installer\sxs.zip")) {
        Get-WindowsOptionalFeature -Online -FeatureName "NetFx3" | Enable-WindowsOptionalFeature -Online -All -NoRestart | Out-Null
    } else {
        $dir_extract = $tmp_dir
        Expand-Archive -Path "$dir_installer\sxs.zip" -DestinationPath $dir_extract -Force
        Get-WindowsOptionalFeature -Online -FeatureName "NetFx3" | Enable-WindowsOptionalFeature -Online -Source "$dir_extract\sxs" -All -NoRestart | Out-Null
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
$appnum_toinclude = $appnum_toinclude_wincomponentWSL
# 
# main Install/Download/Execute
if (($app_num -in $appnum_toinstall_from..$appnum_toinstall_to) -and ($appnum_toinclude -eq 1)) {

    Write-Host "Enabling Microsoft-Windows-Subsystem-Linux ..."
    Get-WindowsOptionalFeature -Online -FeatureName "Microsoft-Windows-Subsystem-Linux" | Enable-WindowsOptionalFeature -Online -All -NoRestart | Out-Null
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
$appnum_toinclude = $appnum_toinclude_wincomponentVMPlatform
# 
# main Install/Download/Execute
if (($app_num -in $appnum_toinstall_from..$appnum_toinstall_to) -and ($appnum_toinclude -eq 1)) {

    Write-Host "Enabling VirtualMachinePlatform ..."
    Get-WindowsOptionalFeature -Online -FeatureName "VirtualMachinePlatform" | Enable-WindowsOptionalFeature -Online -All -NoRestart | Out-Null
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
$appnum_toinclude = $appnum_toinclude_LinuxKernelUpdate
$url_appspecific = $url_wsl2kernel_x64
$dir_installer = "WSL2Kernel" + "x64"
$install_args = "`/passive"
# 
# main Install/Download/Execute
if (($app_num -in $appnum_toinstall_from..$appnum_toinstall_to) -and ($appnum_toinclude -eq 1)) {

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
$appnum_toinclude = $appnum_toinclude_wincomponentHypervisorPlatform
# 
# main Install/Download/Execute
if (($app_num -in $appnum_toinstall_from..$appnum_toinstall_to) -and ($appnum_toinclude -eq 1)) {

    Write-Host "Enabling HypervisorPlatform ..."
    Get-WindowsOptionalFeature -Online -FeatureName "HypervisorPlatform" | Enable-WindowsOptionalFeature -Online -All -NoRestart | Out-Null
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
$appnum_toinclude = $appnum_toinclude_wincomponentHyperV
# 
# main Install/Download/Execute
if (($app_num -in $appnum_toinstall_from..$appnum_toinstall_to) -and ($appnum_toinclude -eq 1)) {

    Write-Host "Enabling Microsoft-Hyper-V ..."
    Get-WindowsOptionalFeature -Online -FeatureName "Microsoft-Hyper-V" | Enable-WindowsOptionalFeature -Online -All -NoRestart | Out-Null
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
$appnum_toinclude = $appnum_toinclude_wincomponentContainers
# 
# main Install/Download/Execute
if (($app_num -in $appnum_toinstall_from..$appnum_toinstall_to) -and ($appnum_toinclude -eq 1)) {

    Write-Host "Enabling Containers ..."
    Get-WindowsOptionalFeature -Online -FeatureName "Containers" | Enable-WindowsOptionalFeature -Online -All -NoRestart | Out-Null
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
$appnum_toinclude = $appnum_toinclude_wincomponentNTVDM
# 
# main Install/Download/Execute
if (($app_num -in $appnum_toinstall_from..$appnum_toinstall_to) -and ($appnum_toinclude -eq 1)) {

    if (-Not [Environment]::Is64BitOperatingSystem) {
        Write-Host "Enabling NTVDM ..."
        Get-WindowsOptionalFeature -Online -FeatureName "NTVDM" | Enable-WindowsOptionalFeature -Online -All -NoRestart | Out-Null
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
$appnum_toinclude = $appnum_toinclude_wincomponentDisablePSv2
# 
# main Install/Download/Execute
if (($app_num -in $appnum_toinstall_from..$appnum_toinstall_to) -and ($appnum_toinclude -eq 1)) {

    Write-Host "Disabling MicrosoftWindowsPowerShellV2Root ..."
    Get-WindowsOptionalFeature -Online -FeatureName "MicrosoftWindowsPowerShellV2Root" | Disable-WindowsOptionalFeature -Online -NoRestart | Out-Null
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
$appnum_toinclude = $appnum_toinclude_wincomponentRemovePSISE
# 
# main Install/Download/Execute
if (($app_num -in $appnum_toinstall_from..$appnum_toinstall_to) -and ($appnum_toinclude -eq 1)) {

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
$appnum_toinclude = $appnum_toinclude_dotNET10HB
$app_wgname = "Microsoft.DotNet.HostingBundle.10"
$dir_installer = "dotNET10HB" + "x64x86"
$install_args = "`/passive `/norestart"
# 
# main Install/Download/Execute
if (($app_num -in $appnum_toinstall_from..$appnum_toinstall_to) -and ($appnum_toinclude -eq 1)) {

    if ($false) {
    # if ($mode_onoffdown -eq 1) {
        # Online
        winget install --id $app_wgname
    } else {
        # Download
        if (-Not (Test-Path -Path $dir_installer)) {
            $url = Get-URL-FromWinget $app_wgname "x64x86"
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
$appnum_toinclude = $appnum_toinclude_dotNET10DRT
$app_wgname = "Microsoft.DotNet.DesktopRuntime.10"
$dir_installer = "dotNET10DRT" + "x86"
$install_args = "`/passive `/norestart"
# 
# main Install/Download/Execute
if (($app_num -in $appnum_toinstall_from..$appnum_toinstall_to) -and ($appnum_toinclude -eq 1)) {

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
$appnum_toinclude = $appnum_toinclude_dotNET10DRT
$app_wgname = "Microsoft.DotNet.DesktopRuntime.10"
$dir_installer = "dotNET10DRT" + $arch_suffix
$install_args = "`/passive `/norestart"
# 
# main Install/Download/Execute
if (($app_num -in $appnum_toinstall_from..$appnum_toinstall_to) -and ($appnum_toinclude -eq 1)) {

    if ($false) {
    # if ($mode_onoffdown -eq 1) {
        # Online
        winget install --id $app_wgname -a $arch_suffix
    } else {
        # Download
        if (-Not (Test-Path -Path $dir_installer)) {
            $url = Get-URL-FromWinget $app_wgname $arch_suffix
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
$appnum_toinclude = $appnum_toinclude_dotNET8HB
$app_wgname = "Microsoft.DotNet.HostingBundle.8"
$dir_installer = "dotNET8HB" + "x64x86"
$install_args = "`/passive `/norestart"
# 
# main Install/Download/Execute
if (($app_num -in $appnum_toinstall_from..$appnum_toinstall_to) -and ($appnum_toinclude -eq 1)) {

    if ($false) {
    # if ($mode_onoffdown -eq 1) {
        # Online
        winget install --id $app_wgname
    } else {
        # Download
        if (-Not (Test-Path -Path $dir_installer)) {
            $url = Get-URL-FromWinget $app_wgname "x64x86"
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
$appnum_toinclude = $appnum_toinclude_dotNET8DRT
$app_wgname = "Microsoft.DotNet.DesktopRuntime.8"
$dir_installer = "dotNET8DRT" + "x86"
$install_args = "`/passive `/norestart"
# 
# main Install/Download/Execute
if (($app_num -in $appnum_toinstall_from..$appnum_toinstall_to) -and ($appnum_toinclude -eq 1)) {

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
$appnum_toinclude = $appnum_toinclude_dotNET8DRT
$app_wgname = "Microsoft.DotNet.DesktopRuntime.8"
$dir_installer = "dotNET8DRT" + $arch_suffix
$install_args = "`/passive `/norestart"
# 
# main Install/Download/Execute
if (($app_num -in $appnum_toinstall_from..$appnum_toinstall_to) -and ($appnum_toinclude -eq 1)) {

    if ($false) {
    # if ($mode_onoffdown -eq 1) {
        # Online
        winget install --id $app_wgname -a $arch_suffix
    } else {
        # Download
        if (-Not (Test-Path -Path $dir_installer)) {
            $url = Get-URL-FromWinget $app_wgname $arch_suffix
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
$appnum_toinclude = $appnum_toinclude_dotNET6HB
$app_wgname = "Microsoft.DotNet.HostingBundle.6"
$url_appspecific = $url_dotnet6HB
$dir_installer = "dotNET6HB" + "x64x86"
$install_args = "`/passive `/norestart"
# 
# main Install/Download/Execute
if (($app_num -in $appnum_toinstall_from..$appnum_toinstall_to) -and ($appnum_toinclude -eq 1)) {

    if ($false) {
    # if ($mode_onoffdown -eq 1) {
        # Online
        winget install --id $app_wgname
    } else {
        # Download
        if (-Not (Test-Path -Path $dir_installer)) {
            $url = Get-URL-FromWinget $app_wgname "x64x86"
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
$appnum_toinclude = $appnum_toinclude_dotNET6DRT
$app_wgname = "Microsoft.DotNet.DesktopRuntime.6"
$url_appspecific = $url_dotnet6DRT_x86
$dir_installer = "dotNET6DRT" + "x86"
$install_args = "`/passive `/norestart"
# 
# main Install/Download/Execute
if (($app_num -in $appnum_toinstall_from..$appnum_toinstall_to) -and ($appnum_toinclude -eq 1)) {

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
$appnum_toinclude = $appnum_toinclude_dotNET6DRT
$app_wgname = "Microsoft.DotNet.DesktopRuntime.6"
$url_appspecific = $url_dotnet6DRT_x64
$dir_installer = "dotNET6DRT" + $arch_suffix
$install_args = "`/passive `/norestart"
# 
# main Install/Download/Execute
if (($app_num -in $appnum_toinstall_from..$appnum_toinstall_to) -and ($appnum_toinclude -eq 1)) {

    if ($false) {
    # if ($mode_onoffdown -eq 1) {
        # Online
        winget install --id $app_wgname -a $arch_suffix
    } else {
        # Download
        if (-Not (Test-Path -Path $dir_installer)) {
            $url = Get-URL-FromWinget $app_wgname $arch_suffix
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
$appnum_toinclude = $appnum_toinclude_dotNET31HB
$app_wgname = "Microsoft.DotNet.HostingBundle.3_1"
$url_appspecific = $url_dotnet31HB
$dir_installer = "dotNET31HB" + "x64x86"
$install_args = "`/passive `/norestart"
# 
# main Install/Download/Execute
if (($app_num -in $appnum_toinstall_from..$appnum_toinstall_to) -and ($appnum_toinclude -eq 1)) {

    if ($false) {
    # if ($mode_onoffdown -eq 1) {
        # Online
        winget install --id $app_wgname
    } else {
        # Download
        if (-Not (Test-Path -Path $dir_installer)) {
            $url = Get-URL-FromWinget $app_wgname "x64x86"
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
$appnum_toinclude = $appnum_toinclude_dotNET31DRT
$app_wgname = "Microsoft.DotNet.DesktopRuntime.3_1"
$url_appspecific = $url_dotnet31DRT_x86
$dir_installer = "dotNET31DRT" + "x86"
$install_args = "`/passive `/norestart"
# 
# main Install/Download/Execute
if (($app_num -in $appnum_toinstall_from..$appnum_toinstall_to) -and ($appnum_toinclude -eq 1)) {

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
$appnum_toinclude = $appnum_toinclude_dotNET31DRT
$app_wgname = "Microsoft.DotNet.DesktopRuntime.3_1"
$url_appspecific = $url_dotnet31DRT_x64
$dir_installer = "dotNET31DRT" + $arch_suffix
$install_args = "`/passive `/norestart"
# 
# main Install/Download/Execute
if (($app_num -in $appnum_toinstall_from..$appnum_toinstall_to) -and ($appnum_toinclude -eq 1)) {

    if ($false) {
    # if ($mode_onoffdown -eq 1) {
        # Online
        winget install --id $app_wgname -a $arch_suffix
    } else {
        # Download
        if (-Not (Test-Path -Path $dir_installer)) {
            $url = Get-URL-FromWinget $app_wgname $arch_suffix
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
$appnum_toinclude = $appnum_toinclude_dotNET21HB
# $app_wgname = "Microsoft.DotNet.HostingBundle.2_1"
$url_appspecific = $url_dotnet21HB
$dir_installer = "dotNET21HB" + "x64x86"
$install_args = "`/passive `/norestart"
# 
# main Install/Download/Execute
if (($app_num -in $appnum_toinstall_from..$appnum_toinstall_to) -and ($appnum_toinclude -eq 1)) {

    if ($false) {
    # if ($mode_onoffdown -eq 1) {
        # Online
        winget install --id $app_wgname
    } else {
        # Download
        if (-Not (Test-Path -Path $dir_installer)) {
            $url = Get-URL-FromWinget $app_wgname "x64x86"
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
$appnum_toinclude = $appnum_toinclude_dotNET481
$app_wgname = "Microsoft.DotNet.Framework.DeveloperPack_4"
$url_appspecific = $url_dotnetfw_481
$dir_installer = "Framework481" + "x64x86"
$install_args = "`/passive `/norestart"
# 
# main Install/Download/Execute
if (($app_num -in $appnum_toinstall_from..$appnum_toinstall_to) -and ($appnum_toinclude -eq 1)) {

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
$appnum_toinclude = $appnum_toinclude_dotNET11
# $app_wgname = "Microsoft.DotNet.Framework.DeveloperPack_1_1"
$dir_extr_dotnetfw11 = "C:\DotNetFramework11wSP1"
$dir_installer = "Framework11wSP1"
$install_args = "`/passive"
# 
# main Install/Download/Execute
if (($app_num -in $appnum_toinstall_from..$appnum_toinstall_to) -and ($appnum_toinclude -eq 1)) {

    if ($mode_onoffdown -ne 3) {

        Write-Host "Installing $dir_installer ..."

        # Expand
        Get-ChildItem -Path $dir_installer -Filter *.zip | Expand-Archive -DestinationPath "C:\" -Force

        # Install
        Start-Process -FilePath "$dir_extr_dotnetfw11\netfx.msi" -ArgumentList "`/passive" -Wait

        # Remove
        Remove-Item -Path $dir_extr_dotnetfw11 -Recurse -Force

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
$appnum_toinclude = $appnum_toinclude_vcpp2005
$app_wgname = "Microsoft.VCRedist.2005.x86"
$dir_installer = "VCPP_VCPP2005" + "x86"
$install_args = "`/Q"
# 
# main Install/Download/Execute
if (($app_num -in $appnum_toinstall_from..$appnum_toinstall_to) -and ($appnum_toinclude -eq 1)) {

    if ($false) {
    # if ($mode_onoffdown -eq 1) {
        # Online
        winget install --id $app_wgname
    } else {
        # Download
        if (-Not (Test-Path -Path $dir_installer)) {
            $url = Get-URL-FromWinget $app_wgname "x64x86"
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
$appnum_toinclude = $appnum_toinclude_vcpp2005
$app_wgname = "Microsoft.VCRedist.2005.x64"
$dir_installer = "VCPP_VCPP2005" + $arch_suffix
$install_args = "`/Q"
# 
# main Install/Download/Execute
if (($app_num -in $appnum_toinstall_from..$appnum_toinstall_to) -and ($appnum_toinclude -eq 1)) {

    if ($false) {
    # if ($mode_onoffdown -eq 1) {
        # Online
        winget install --id $app_wgname
    } else {
        # Download
        if (-Not (Test-Path -Path $dir_installer)) {
            $url = Get-URL-FromWinget $app_wgname "x64x86"
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
$appnum_toinclude = $appnum_toinclude_vcpp2008
$app_wgname = "Microsoft.VCRedist.2008.x86"
$dir_installer = "VCPP_VCPP2008" + "x86"
$install_args = "`/qb `/norestart"
# 
# main Install/Download/Execute
if (($app_num -in $appnum_toinstall_from..$appnum_toinstall_to) -and ($appnum_toinclude -eq 1)) {

    if ($false) {
    # if ($mode_onoffdown -eq 1) {
        # Online
        winget install --id $app_wgname
    } else {
        # Download
        if (-Not (Test-Path -Path $dir_installer)) {
            $url = Get-URL-FromWinget $app_wgname "x64x86"
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
$appnum_toinclude = $appnum_toinclude_vcpp2008
$app_wgname = "Microsoft.VCRedist.2008.x64"
$dir_installer = "VCPP_VCPP2008" + $arch_suffix
$install_args = "`/qb `/norestart"
# 
# main Install/Download/Execute
if (($app_num -in $appnum_toinstall_from..$appnum_toinstall_to) -and ($appnum_toinclude -eq 1)) {

    if ($false) {
    # if ($mode_onoffdown -eq 1) {
        # Online
        winget install --id $app_wgname
    } else {
        # Download
        if (-Not (Test-Path -Path $dir_installer)) {
            $url = Get-URL-FromWinget $app_wgname "x64x86"
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
$appnum_toinclude = $appnum_toinclude_vcpp2010
$app_wgname = "Microsoft.VCRedist.2010.x86"
$dir_installer = "VCPP_VCPP2010" + "x86"
$install_args = "`/passive `/norestart"
# 
# main Install/Download/Execute
if (($app_num -in $appnum_toinstall_from..$appnum_toinstall_to) -and ($appnum_toinclude -eq 1)) {

    if ($false) {
    # if ($mode_onoffdown -eq 1) {
        # Online
        winget install --id $app_wgname
    } else {
        # Download
        if (-Not (Test-Path -Path $dir_installer)) {
            $url = Get-URL-FromWinget $app_wgname "x64x86"
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
$appnum_toinclude = $appnum_toinclude_vcpp2010
$app_wgname = "Microsoft.VCRedist.2010.x64"
$dir_installer = "VCPP_VCPP2010" + $arch_suffix
$install_args = "`/passive `/norestart"
# 
# main Install/Download/Execute
if (($app_num -in $appnum_toinstall_from..$appnum_toinstall_to) -and ($appnum_toinclude -eq 1)) {

    if ($false) {
    # if ($mode_onoffdown -eq 1) {
        # Online
        winget install --id $app_wgname
    } else {
        # Download
        if (-Not (Test-Path -Path $dir_installer)) {
            $url = Get-URL-FromWinget $app_wgname "x64x86"
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
$appnum_toinclude = $appnum_toinclude_vcpp2012
$app_wgname = "Microsoft.VCRedist.2012.x86"
$dir_installer = "VCPP_VCPP2012" + "x86"
$install_args = "`/passive `/norestart"
# 
# main Install/Download/Execute
if (($app_num -in $appnum_toinstall_from..$appnum_toinstall_to) -and ($appnum_toinclude -eq 1)) {

    if ($false) {
    # if ($mode_onoffdown -eq 1) {
        # Online
        winget install --id $app_wgname
    } else {
        # Download
        if (-Not (Test-Path -Path $dir_installer)) {
            $url = Get-URL-FromWinget $app_wgname "x64x86"
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
$appnum_toinclude = $appnum_toinclude_vcpp2012
$app_wgname = "Microsoft.VCRedist.2012.x64"
$dir_installer = "VCPP_VCPP2012" + $arch_suffix
$install_args = "`/passive `/norestart"
# 
# main Install/Download/Execute
if (($app_num -in $appnum_toinstall_from..$appnum_toinstall_to) -and ($appnum_toinclude -eq 1)) {

    if ($false) {
    # if ($mode_onoffdown -eq 1) {
        # Online
        winget install --id $app_wgname
    } else {
        # Download
        if (-Not (Test-Path -Path $dir_installer)) {
            $url = Get-URL-FromWinget $app_wgname "x64x86"
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
$appnum_toinclude = $appnum_toinclude_vcpp2013
$app_wgname = "Microsoft.VCRedist.2013.x86"
$dir_installer = "VCPP_VCPP2013" + "x86"
$install_args = "`/passive `/norestart"
# 
# main Install/Download/Execute
if (($app_num -in $appnum_toinstall_from..$appnum_toinstall_to) -and ($appnum_toinclude -eq 1)) {

    if ($false) {
    # if ($mode_onoffdown -eq 1) {
        # Online
        winget install --id $app_wgname
    } else {
        # Download
        if (-Not (Test-Path -Path $dir_installer)) {
            $url = Get-URL-FromWinget $app_wgname "x64x86"
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
$appnum_toinclude = $appnum_toinclude_vcpp2013
$app_wgname = "Microsoft.VCRedist.2013.x64"
$dir_installer = "VCPP_VCPP2013" + $arch_suffix
$install_args = "`/passive `/norestart"
# 
# main Install/Download/Execute
if (($app_num -in $appnum_toinstall_from..$appnum_toinstall_to) -and ($appnum_toinclude -eq 1)) {

    if ($false) {
    # if ($mode_onoffdown -eq 1) {
        # Online
        winget install --id $app_wgname
    } else {
        # Download
        if (-Not (Test-Path -Path $dir_installer)) {
            $url = Get-URL-FromWinget $app_wgname "x64x86"
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
$appnum_toinclude = $appnum_toinclude_vcpp2015plus
$app_wgname = "Microsoft.VCRedist.2015+.x86"
$dir_installer = "VCPP_VCPP2015plus" + "x86"
$install_args = "`/passive `/norestart"
# 
# main Install/Download/Execute
if (($app_num -in $appnum_toinstall_from..$appnum_toinstall_to) -and ($appnum_toinclude -eq 1)) {

    if ($false) {
    # if ($mode_onoffdown -eq 1) {
        # Online
        winget install --id $app_wgname
    } else {
        # Download
        if (-Not (Test-Path -Path $dir_installer)) {
            $url = Get-URL-FromWinget $app_wgname "x64x86"
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
$appnum_toinclude = $appnum_toinclude_vcpp2015plus
$app_wgname = "Microsoft.VCRedist.2015+.x64"
$dir_installer = "VCPP_VCPP2015plus" + $arch_suffix
$install_args = "`/passive `/norestart"
# 
# main Install/Download/Execute
if (($app_num -in $appnum_toinstall_from..$appnum_toinstall_to) -and ($appnum_toinclude -eq 1)) {

    if ($false) {
    # if ($mode_onoffdown -eq 1) {
        # Online
        winget install --id $app_wgname
    } else {
        # Download
        if (-Not (Test-Path -Path $dir_installer)) {
            $url = Get-URL-FromWinget $app_wgname "x64x86"
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
$appnum_toinclude = $appnum_toinclude_vcpp14
$app_wgname = "Microsoft.VCRedist.14.x86"
$url_appspecific = $url_vcpp_14_x86
$dir_installer = "VCPP_VCPP14" + "x86"
$install_args = "`/passive `/norestart"
# 
# main Install/Download/Execute
if (($app_num -in $appnum_toinstall_from..$appnum_toinstall_to) -and ($appnum_toinclude -eq 1)) {

    if ($false) {
    # if ($mode_onoffdown -eq 1) {
        # Online
        winget install --id $app_wgname
    } else {
        # Download
        if (-Not (Test-Path -Path $dir_installer)) {
            # $url = Get-URL-FromWinget $app_wgname "x64x86"
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
$appnum_toinclude = $appnum_toinclude_vcpp14
$app_wgname = "Microsoft.VCRedist.14.x64"
$url_appspecific = $url_vcpp_14_x64
$dir_installer = "VCPP_VCPP14" + $arch_suffix
$install_args = "`/passive `/norestart"
# 
# main Install/Download/Execute
if (($app_num -in $appnum_toinstall_from..$appnum_toinstall_to) -and ($appnum_toinclude -eq 1)) {

    if ($false) {
    # if ($mode_onoffdown -eq 1) {
        # Online
        winget install --id $app_wgname
    } else {
        # Download
        if (-Not (Test-Path -Path $dir_installer)) {
            # $url = Get-URL-FromWinget $app_wgname "x64x86"
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
$appnum_toinclude = $appnum_toinclude_cppdb11
$url_appspecific = $url_cppdb_11_x86
$dir_installer = "VCPP_CPPDB11" + "x86"
$install_args = "`/passive `/norestart"
# 
# main Install/Download/Execute
if (($app_num -in $appnum_toinstall_from..$appnum_toinstall_to) -and ($appnum_toinclude -eq 1)) {

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
$appnum_toinclude = $appnum_toinclude_cppdb12
$url_appspecific = $url_cppdb_12_x86
$dir_installer = "VCPP_CPPDB12" + "x86"
$install_args = "`/passive `/norestart"
# 
# main Install/Download/Execute
if (($app_num -in $appnum_toinstall_from..$appnum_toinstall_to) -and ($appnum_toinclude -eq 1)) {

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
$appnum_toinclude = $appnum_toinclude_Python3
$app_wgname = "Python.Python.3.13"
$dir_installer = "Python3" + $arch_suffix
$install_args = "`/passive InstallAllUsers=1 PrependPath=1"
# 
# main Install/Download/Execute
if (($app_num -in $appnum_toinstall_from..$appnum_toinstall_to) -and ($appnum_toinclude -eq 1)) {

    if ($mode_onoffdown -eq 1) {
        # Online
        winget install --id $app_wgname -a $arch_suffix
    } else {
        # Download
        if (-Not (Test-Path -Path $dir_installer)) {
            $url = Get-URL-FromWinget $app_wgname $arch_suffix
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
$appnum_toinclude = $appnum_toinclude_Python2
$app_wgname = "Python.Python.2"
$dir_installer = "Python2" + $arch_suffix
$install_args = "`/passive `/norestart ADDLOCAL=ALL"
# 
# main Install/Download/Execute
if (($app_num -in $appnum_toinstall_from..$appnum_toinstall_to) -and ($appnum_toinclude -eq 1)) {

    if ($mode_onoffdown -eq 1) {
        # Online
        winget install --id $app_wgname -a $arch_suffix
    } else {
        # Download
        if (-Not (Test-Path -Path $dir_installer)) {
            $url = Get-URL-FromWinget $app_wgname $arch_suffix
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
$appnum_toinclude = $appnum_toinclude_SublimeText
$app_wgname = "SublimeHQ.SublimeText.4"
$dir_installer = "SublimeText" + $arch_suffix
$install_args = "`/SILENT"
$path_file_shortcut = "$dir_startmenuprograms_allusers\Sublime Text.lnk"
# 
# main Install/Download/Execute
if (($app_num -in $appnum_toinstall_from..$appnum_toinstall_to) -and ($appnum_toinclude -eq 1)) {

    if ($false) {
    # if ($mode_onoffdown -eq 1) {
        # Online
        winget install --id $app_wgname -a $arch_suffix
    } else {
        # Download
        if (-Not (Test-Path -Path $dir_installer)) {
            $url = Get-URL-FromWinget $app_wgname $arch_suffix
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
$appnum_toinclude = $appnum_toinclude_RestartMidway
# 
# main Install/Download/Execute
if (($app_num -in $appnum_toinstall_from..$appnum_toinstall_to) -and ($appnum_toinclude -eq 1)) {
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
$appnum_toinclude = $appnum_toinclude_PowerShell
$app_wgname = "Microsoft.PowerShell"
$dir_installer = "Powershell" + "x64x86"
$install_args = "`/passive"
$path_file_shortcut = "$dir_startmenuprograms_allusers\PowerShell\PowerShell 7 (x64).lnk"
# 
# main Install/Download/Execute
if (($app_num -in $appnum_toinstall_from..$appnum_toinstall_to) -and ($appnum_toinclude -eq 1)) {

    if ($mode_onoffdown -eq 1) {
        # Online
        winget install --id $app_wgname
    } else {
        # Download
        if (-Not (Test-Path -Path $dir_installer)) {
            $url = Get-URL-FromWinget $app_wgname "x64x86"
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
$appnum_toinclude = $appnum_toinclude_WinTerminal
$app_wgname = "Microsoft.WindowsTerminal"
$dir_installer = "WinTerminal" + "x64x86"
$install_args = ""
# 
# main Install/Download/Execute
if (($app_num -in $appnum_toinstall_from..$appnum_toinstall_to) -and ($appnum_toinclude -eq 1)) {

    if ($mode_onoffdown -eq 1) {
        # Online
        winget install --id $app_wgname
    } else {
        # Download
        if (-Not (Test-Path -Path $dir_installer)) {
            $url = Get-URL-FromWinget $app_wgname "x64x86"
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
$appnum_toinclude = $appnum_toinclude_VSCode
$app_wgname = "Microsoft.VisualStudioCode"
if ($arch_suffix -eq "a64") {
    $url_appspecific = $url_vscode_a64
} else {
    $url_appspecific = $url_vscode_x64
}
$dir_installer = "VSCode" + $arch_suffix
$install_args = "`/SILENT `/NORESTART `/MERGETASKS=!runcode"
$path_file_shortcut = "$dir_startmenuprograms_allusers\Visual Studio Code\Visual Studio Code.lnk"
# 
# main Install/Download/Execute
if (($app_num -in $appnum_toinstall_from..$appnum_toinstall_to) -and ($appnum_toinclude -eq 1)) {

    if ($false) {
    # if ($mode_onoffdown -eq 1) {
        # Online
        winget install --id $app_wgname -a $arch_suffix
    } else {
        # Download
        if (-Not (Test-Path -Path $dir_installer)) {
            $url = $url_appspecific
            Downloa-Installe $url $dir_installer
            Get-ChildItem -Path $dir_installer | Rename-Item -NewName "VSCodeSetup-_ver_$arch_suffix.exe"
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
$appnum_toinclude = $appnum_toinclude_WSL
# 
# main Install/Download/Execute
if (($app_num -in $appnum_toinstall_from..$appnum_toinstall_to) -and ($appnum_toinclude -eq 1)) {


    # set wsl2 as default
    wsl --set-default-version 2


    # Linux Distro
    # 
    # param
    $app_wgname = "Canonical.Ubuntu.2404"
    $dir_installer = "WSLUbuntu" + "x64x86"
    $install_args = ""
    # 
    # main Install/Download/Execute
    if ($mode_onoffdown -eq 1) {
        # Online
        winget install --id $app_wgname
    } else {
        # Download
        if (-Not (Test-Path -Path $dir_installer)) {
            $url = Get-URL-FromWinget $app_wgname "x64x86"
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
$appnum_toinclude = $appnum_toinclude_iTunes
$app_wgname = "Apple.iTunes"
$dir_installer = "iTunes" + $arch_suffix
$install_args = "`/qn `/norestart"
# 
# main Install/Download/Execute
if (($app_num -in $appnum_toinstall_from..$appnum_toinstall_to) -and ($appnum_toinclude -eq 1)) {

    if ($mode_onoffdown -eq 1) {
        # Online
        winget install --id $app_wgname -a $arch_suffix
    } else {
        # Download
        if (-Not (Test-Path -Path $dir_installer)) {
            $url = Get-URL-FromWinget $app_wgname $arch_suffix
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
$appnum_toinclude = $appnum_toinclude_Edge
$app_wgname = "Microsoft.Edge"
$dir_installer = "Edge" + $arch_suffix
$install_args = "`/passive"
$path_file_shortcut = "$dir_startmenuprograms_allusers\Microsoft Edge.lnk"
# 
# main Install/Download/Execute
if (($app_num -in $appnum_toinstall_from..$appnum_toinstall_to) -and ($appnum_toinclude -eq 1)) {

    if ($false) {
    # if ($mode_onoffdown -eq 1) {
        # Online
        winget install --id $app_wgname -a $arch_suffix
    } else {
        # Download
        if (-Not (Test-Path -Path $dir_installer)) {
            $url = Get-URL-FromWinget $app_wgname $arch_suffix
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
$appnum_toinclude = $appnum_toinclude_Teams
$app_wgname = "Microsoft.Teams"
$app_msstore_id = "XP8BT8DW290MPQ"
$dir_installer = "Teams" + $arch_suffix
$install_args = "`/S"
# 
# main Install/Download/Execute
if (($app_num -in $appnum_toinstall_from..$appnum_toinstall_to) -and ($appnum_toinclude -eq 1)) {

    if ($mode_onoffdown -ne 3) {
        winget install --id $app_wgname
        # winget install --id $app_msstore_id --accept-source-agreements --accept-package-agreements
        Write-Host ""
    }

    # if ($mode_onoffdown -eq 1) {
    #     # Online
    #     winget install --id $app_wgname -a $arch_suffix
    # } else {
    #     # Download
    #     if (-Not (Test-Path -Path $dir_installer)) {
    #         $url = Get-URL-FromWinget $app_wgname $arch_suffix
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
$appnum_toinclude = $appnum_toinclude_Skype
$app_wgname = "Microsoft.Skype"
$dir_installer = "Skype" + "x64x86"
$install_args = "`/SILENT"
$path_file_shortcut = "$dir_startmenuprograms_allusers\Skype\Skype.lnk"
# 
# main Install/Download/Execute
if (($app_num -in $appnum_toinstall_from..$appnum_toinstall_to) -and ($appnum_toinclude -eq 1)) {

    if ($mode_onoffdown -eq 1) {
        # Online
        winget install --id $app_wgname
    } else {
        # Download
        if (-Not (Test-Path -Path $dir_installer)) {
            $url = Get-URL-FromWinget $app_wgname "x64x86"
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
$appnum_toinclude = $appnum_toinclude_WinEssentials
$url_appspecific = $url_winessentials_2012
$dir_installer = "WindowsEssentials" + "x64x86"
$install_args = "`/AppSelect:MovieMaker `/AppSelect:Mail `/silent `/noceip `/nohomepage `/nolaunch `/nomu `/nosearch `/notoolbarceip"
$path_file_shortcut = "$dir_startmenuprograms_allusers\Movie Maker.lnk"
# 
# main Install/Download/Execute
if (($app_num -in $appnum_toinstall_from..$appnum_toinstall_to) -and ($appnum_toinclude -eq 1)) {

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
$appnum_toinclude = $appnum_toinclude_Chrome
$app_wgname = "Google.Chrome"
$dir_installer = "Chrome" + $arch_suffix
$install_args = "`/passive"
$path_file_shortcut = "$dir_startmenuprograms_allusers\Google Chrome.lnk"
# 
# main Install/Download/Execute
if (($app_num -in $appnum_toinstall_from..$appnum_toinstall_to) -and ($appnum_toinclude -eq 1)) {

    if ($false) {
    # if ($mode_onoffdown -eq 1) {
        # Online
        winget install --id $app_wgname -a $arch_suffix
    } else {
        # Download
        if (-Not (Test-Path -Path $dir_installer)) {
            $url = Get-URL-FromWinget $app_wgname $arch_suffix
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
$appnum_toinclude = $appnum_toinclude_Drive
$app_wgname = "Google.GoogleDrive"
$dir_installer = "GoogleDrive" + "x64x86"
$install_args = "--silent"
$path_file_shortcut = "$dir_startmenuprograms_allusers\Google Drive.lnk"
# 
# main Install/Download/Execute
if (($app_num -in $appnum_toinstall_from..$appnum_toinstall_to) -and ($appnum_toinclude -eq 1)) {

    if ($mode_onoffdown -eq 1) {
        # Online
        winget install --id $app_wgname
    } else {
        # Download
        if (-Not (Test-Path -Path $dir_installer)) {
            $url = Get-URL-FromWinget $app_wgname "x64x86"
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
$appnum_toinclude = $appnum_toinclude_Messenger
$app_wgname = "Meta.Messenger"
$app_msstore_id = "9WZDNCRF0083"
$dir_installer = "Messenger" + $arch_suffix
$install_args = "`/passive"
# 
# main Install/Download/Execute
if (($app_num -in $appnum_toinstall_from..$appnum_toinstall_to) -and ($appnum_toinclude -eq 1)) {

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
$appnum_toinclude = $appnum_toinclude_AcrobatReader
if ($arch_suffix -eq "x64") {
    $app_wgname = "Adobe.Acrobat.Reader.64-bit"
} else {
    $app_wgname = "Adobe.Acrobat.Reader.32-bit"
}
$dir_installer = "AcrobatReader" + $arch_suffix
$install_args = "`/sPB `/rs"
$path_file_shortcut = "$dir_startmenuprograms_allusers\Adobe Acrobat.lnk"
# note for Acrobat XI it is "$dir_startmenuprograms_allusers\Adobe Acrobat XI Pro.lnk"
# 
# main Install/Download/Execute
if (($app_num -in $appnum_toinstall_from..$appnum_toinstall_to) -and ($appnum_toinclude -eq 1)) {

    # if ($false) {
    if ($mode_onoffdown -eq 1) {
        # Online
        winget install --id $app_wgname
    } else {
        # Download
        if (-Not (Test-Path -Path $dir_installer)) {
            $url = Get-URL-FromWinget $app_wgname "x64x86"
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
$appnum_toinclude = $appnum_toinclude_Dropbox
$app_wgname = "Dropbox.Dropbox"
$dir_installer = "Dropbox" + $arch_suffix
$install_args = "`/NOLAUNCH"
$path_file_shortcut = "$dir_startmenuprograms_allusers\Dropbox\Dropbox.lnk"
# 
# main Install/Download/Execute
if (($app_num -in $appnum_toinstall_from..$appnum_toinstall_to) -and ($appnum_toinclude -eq 1)) {

    if ($mode_onoffdown -eq 1) {
        # Online
        winget install --id $app_wgname -a $arch_suffix
    } else {
        # Download
        if (-Not (Test-Path -Path $dir_installer)) {
            $url = Get-URL-FromWinget $app_wgname $arch_suffix
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
$appnum_toinclude = $appnum_toinclude_Zoom
$app_wgname = "Zoom.Zoom"
$dir_installer = "Zoom" + $arch_suffix
$install_args = "`/passive ZoomAutoUpdate='true'"
$path_file_shortcut = "$dir_startmenuprograms_allusers\Zoom\Zoom Workplace.lnk"
# 
# main Install/Download/Execute
if (($app_num -in $appnum_toinstall_from..$appnum_toinstall_to) -and ($appnum_toinclude -eq 1)) {

    if ($mode_onoffdown -eq 1) {
        # Online
        winget install --id $app_wgname -a $arch_suffix
    } else {
        # Download
        if (-Not (Test-Path -Path $dir_installer)) {
            $url = Get-URL-FromWinget $app_wgname $arch_suffix
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
$appnum_toinclude = $appnum_toinclude_Discord
$app_wgname = "Discord.Discord"
$dir_installer = "Discord" + $arch_suffix
$install_args = "-s"
$path_file_shortcut = "$dir_startmenuprograms_currentuser\Discord Inc\Discord.lnk"
# 
# main Install/Download/Execute
if (($app_num -in $appnum_toinstall_from..$appnum_toinstall_to) -and ($appnum_toinclude -eq 1)) {

    if ($mode_onoffdown -eq 1) {
        # Online
        winget install --id $app_wgname -a $arch_suffix
    } else {
        # Download
        if (-Not (Test-Path -Path $dir_installer)) {
            $url = Get-URL-FromWinget $app_wgname $arch_suffix
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
$appnum_toinclude = $appnum_toinclude_Telegram
$app_wgname = "Telegram.TelegramDesktop"
$dir_installer = "Telegram" + $arch_suffix
$install_args = "`/SILENT `/NORESTART"
$path_file_shortcut = "$dir_startmenuprograms_currentuser\Telegram Desktop\Telegram.lnk"
# 
# main Install/Download/Execute
if (($app_num -in $appnum_toinstall_from..$appnum_toinstall_to) -and ($appnum_toinclude -eq 1)) {

    if ($mode_onoffdown -eq 1) {
        # Online
        winget install --id $app_wgname -a $arch_suffix
    } else {
        # Download
        if (-Not (Test-Path -Path $dir_installer)) {
            $url = Get-URL-FromWinget $app_wgname $arch_suffix
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
$appnum_toinclude = $appnum_toinclude_WhatsApp
$app_wgname = "WhatsApp.WhatsApp"
$app_msstore_id = "9NKSQGP7F2NH"
$dir_installer = "WhatsApp" + $arch_suffix
$install_args = "--silent"
# 
# main Install/Download/Execute
if (($app_num -in $appnum_toinstall_from..$appnum_toinstall_to) -and ($appnum_toinclude -eq 1)) {

    if ($mode_onoffdown -ne 3) {
        winget install --id $app_msstore_id --accept-source-agreements --accept-package-agreements
        Write-Host ""
    }

    # if ($mode_onoffdown -eq 1) {
    #     # Online
    #     winget install --id $app_wgname -a $arch_suffix
    # } else {
    #     # Download
    #     if (-Not (Test-Path -Path $dir_installer)) {
    #         $url = Get-URL-FromWinget $app_wgname $arch_suffix
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
$appnum_toinclude = $appnum_toinclude_WeChat
$app_wgname = "Tencent.WeChat"
$dir_installer = "WeChat" + "x64x86"
$install_args = "`/S"
$path_file_shortcut = "$dir_startmenuprograms_allusers\WeChat\WeChat.lnk"
# 
# main Install/Download/Execute
if (($app_num -in $appnum_toinstall_from..$appnum_toinstall_to) -and ($appnum_toinclude -eq 1)) {

    if ($mode_onoffdown -eq 1) {
        # Online
        winget install --id $app_wgname
    } else {
        # Download
        if (-Not (Test-Path -Path $dir_installer)) {
            $url = Get-URL-FromWinget $app_wgname "x64x86"
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
$appnum_toinclude = $appnum_toinclude_TeamViewer
$app_wgname = "TeamViewer.TeamViewer"
$dir_installer = "TeamViewerLatest" + $arch_suffix
$install_args = "`/S"
$path_file_shortcut = "$dir_startmenuprograms_allusers\TeamViewer.lnk"
# 
# main Install/Download/Execute
if (($app_num -in $appnum_toinstall_from..$appnum_toinstall_to) -and ($appnum_toinclude -eq 1)) {

    if ($mode_onoffdown -eq 1) {
        # Online
        winget install --id $app_wgname -a $arch_suffix
    } else {
        # Download
        if (-Not (Test-Path -Path $dir_installer)) {
            $url = Get-URL-FromWinget $app_wgname $arch_suffix
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
$appnum_toinclude = $appnum_toinclude_TeamViewer
$url_appspecific = $url_teamviewerqs_13
$dir_installer = "TeamViewerQS13"
$path_file_shortcut = "$dir_startmenuprograms_allusers\TeamViewerQS.lnk"
# 
# main Install/Download/Execute
if (($app_num -in $appnum_toinstall_from..$appnum_toinstall_to) -and ($appnum_toinclude -eq 1)) {

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
$appnum_toinclude = $appnum_toinclude_SevenZip
$app_wgname = "7zip.7zip"
$dir_installer = "SevenZip" + $arch_suffix
$install_args = "`/passive"
$path_file_shortcut = "$dir_startmenuprograms_allusers\7-Zip\7-Zip File Manager.lnk"
# 
# main Install/Download/Execute
if (($app_num -in $appnum_toinstall_from..$appnum_toinstall_to) -and ($appnum_toinclude -eq 1)) {

    if ($mode_onoffdown -eq 1) {
        # Online
        winget install --id $app_wgname -a $arch_suffix
    } else {
        # Download
        if (-Not (Test-Path -Path $dir_installer)) {
            $url = Get-URL-FromWinget $app_wgname $arch_suffix
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
$appnum_toinclude = $appnum_toinclude_WinRAR
$app_wgname = "RARLab.WinRAR"
$dir_installer = "WinRAR" + $arch_suffix
$install_args = "`/S"
$path_file_shortcut = "$dir_startmenuprograms_allusers\WinRAR\WinRAR.lnk"
# 
# main Install/Download/Execute
if (($app_num -in $appnum_toinstall_from..$appnum_toinstall_to) -and ($appnum_toinclude -eq 1)) {

    if ($mode_onoffdown -eq 1) {
        # Online
        winget install --id $app_wgname -a $arch_suffix
    } else {
        # Download
        if (-Not (Test-Path -Path $dir_installer)) {
            $url = Get-URL-FromWinget $app_wgname $arch_suffix
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
$appnum_toinclude = $appnum_toinclude_VLC
$app_wgname = "VideoLAN.VLC"
$dir_installer = "VLC" + $arch_suffix
$install_args = "`/S"
$path_file_shortcut = "$dir_startmenuprograms_allusers\VideoLAN\VLC media player.lnk"
# 
# main Install/Download/Execute
if (($app_num -in $appnum_toinstall_from..$appnum_toinstall_to) -and ($appnum_toinclude -eq 1)) {

    # slow winget download, use offline
    if ($false) {
    # if ($mode_onoffdown -eq 1) {
        # Online
        winget install --id $app_wgname -a $arch_suffix
    } else {
        # Download
        if (-Not (Test-Path -Path $dir_installer)) {
            $url = Get-URL-FromWinget $app_wgname $arch_suffix
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
$appnum_toinclude = $appnum_toinclude_Java8
$app_wgname = "Oracle.JavaRuntimeEnvironment"
$dir_installer = "Java8" + "x86"
$install_args = "`/s"
# 
# main Install/Download/Execute
if (($app_num -in $appnum_toinstall_from..$appnum_toinstall_to) -and ($appnum_toinclude -eq 1)) {

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
$appnum_toinclude = $appnum_toinclude_Java8
$app_wgname = "Oracle.JavaRuntimeEnvironment"
$dir_installer = "Java8" + $arch_suffix
$install_args = "`/s"
# 
# main Install/Download/Execute
if (($app_num -in $appnum_toinstall_from..$appnum_toinstall_to) -and ($appnum_toinclude -eq 1)) {

    if ($false) {
    # if ($mode_onoffdown -eq 1) {
        # Online
        winget install --id $app_wgname -a $arch_suffix
    } else {
        # Download
        if (-Not (Test-Path -Path $dir_installer)) {
            $url = Get-URL-FromWinget $app_wgname $arch_suffix
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
$appnum_toinclude = $appnum_toinclude_OpenVPN
$app_wgname = "OpenVPNTechnologies.OpenVPNConnect"
$dir_installer = "OpenVPN" + $arch_suffix
$install_args = "`/passive"
$path_file_shortcut = "$dir_startmenuprograms_allusers\OpenVPN Connect\OpenVPN Connect.lnk"
# 
# main Install/Download/Execute
if (($app_num -in $appnum_toinstall_from..$appnum_toinstall_to) -and ($appnum_toinclude -eq 1)) {

    if ($mode_onoffdown -eq 1) {
        # Online
        winget install --id $app_wgname -a $arch_suffix
    } else {
        # Download
        if (-Not (Test-Path -Path $dir_installer)) {
            $url = Get-URL-FromWinget $app_wgname $arch_suffix
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
$appnum_toinclude = $appnum_toinclude_WireGuard
$app_wgname = "WireGuard.WireGuard"
$dir_installer = "WireGuard" + $arch_suffix
$install_args = "`/passive"
$path_file_shortcut = "$dir_startmenuprograms_allusers\WireGuard.lnk"
# 
# main Install/Download/Execute
if (($app_num -in $appnum_toinstall_from..$appnum_toinstall_to) -and ($appnum_toinclude -eq 1)) {

    if ($mode_onoffdown -eq 1) {
        # Online
        winget install --id $app_wgname -a $arch_suffix
    } else {
        # Download
        if (-Not (Test-Path -Path $dir_installer)) {
            $url = Get-URL-FromWinget $app_wgname $arch_suffix
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
$appnum_toinclude = $appnum_toinclude_Firefox
$app_wgname = "Mozilla.Firefox"
$dir_installer = "Firefox" + $arch_suffix
$install_args = "`-ms"
$path_file_shortcut = "$dir_startmenuprograms_allusers\Firefox.lnk"
# 
# main Install/Download/Execute
if (($app_num -in $appnum_toinstall_from..$appnum_toinstall_to) -and ($appnum_toinclude -eq 1)) {

    if ($mode_onoffdown -eq 1) {
        # Online
        winget install --id $app_wgname -a $arch_suffix
    } else {
        # Download
        if (-Not (Test-Path -Path $dir_installer)) {
            $url = Get-URL-FromWinget $app_wgname $arch_suffix
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
$appnum_toinclude = $appnum_toinclude_Thunderbird
$app_wgname = "Mozilla.Thunderbird"
$dir_installer = "Thunderbird" + $arch_suffix
$install_args = "`/passive"
$path_file_shortcut = "$dir_startmenuprograms_allusers\Thunderbird.lnk"
# 
# main Install/Download/Execute
if (($app_num -in $appnum_toinstall_from..$appnum_toinstall_to) -and ($appnum_toinclude -eq 1)) {

    if ($mode_onoffdown -eq 1) {
        # Online
        winget install --id $app_wgname -a $arch_suffix
    } else {
        # Download
        if (-Not (Test-Path -Path $dir_installer)) {
            $url = Get-URL-FromWinget $app_wgname $arch_suffix
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
$appnum_toinclude = $appnum_toinclude_OBS
$app_wgname = "OBSProject.OBSStudio"
$dir_installer = "OBS" + "x64x86"
$install_args = "`/S"
$path_file_shortcut = "$dir_startmenuprograms_allusers\OBS Studio\OBS Studio (64bit).lnk"
# 
# main Install/Download/Execute
if (($app_num -in $appnum_toinstall_from..$appnum_toinstall_to) -and ($appnum_toinclude -eq 1)) {

    if ($mode_onoffdown -eq 1) {
        # Online
        winget install --id $app_wgname
    } else {
        # Download
        if (-Not (Test-Path -Path $dir_installer)) {
            $url = Get-URL-FromWinget $app_wgname "x64x86"
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
$appnum_toinclude = $appnum_toinclude_LibreOffice
$app_wgname = "TheDocumentFoundation.LibreOffice"
$dir_installer = "LibreOffice" + "x64x86"
$install_args = "`/passive"
$path_file_shortcut = "$dir_startmenuprograms_allusers\LibreOffice\LibreOffice.lnk"
# 
# main Install/Download/Execute
if (($app_num -in $appnum_toinstall_from..$appnum_toinstall_to) -and ($appnum_toinclude -eq 1)) {

    if ($mode_onoffdown -eq 1) {
        # Online
        winget install --id $app_wgname -a $arch_suffix
    } else {
        # Download
        if (-Not (Test-Path -Path $dir_installer)) {
            $url = Get-URL-FromWinget $app_wgname $arch_suffix
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
$appnum_toinclude = $appnum_toinclude_Office
# 
# main Install/Download/Execute
if (($app_num -in $appnum_toinstall_from..$appnum_toinstall_to) -and ($appnum_toinclude -eq 1)) {

    # Prepare

    # define locations
    # original downloaded file
    $dir_origfile_odt2016Plus = "ODT2016Plus"
    $dir_origfile_odt2013 = "ODT2013"
    # extracted setup.exe file
    $dir_setupexe_odt2016Plus = "$env:ProgramFiles\OfficeDeploymentTool"
    if ([Environment]::Is64BitOperatingSystem) {
        $dir_setupexe_odt2013 = "${env:ProgramFiles(x86)}\Office2013DeploymentTool"
    } else {
        $dir_setupexe_odt2013 = "$env:ProgramFiles\Office2013DeploymentTool"
    }

    # if setup.exe does not exist, create empty folders
    New-Item -ItemType "directory" -Path $dir_setupexe_odt2016Plus -Force | Out-Null
    if (-Not (Test-Path -Path "$dir_setupexe_odt2016Plus\setup.exe")) {
        # Del
        Get-ChildItem -Path $dir_setupexe_odt2016Plus -Recurse | Remove-Item -Recurse -Force
    }
    New-Item -ItemType "directory" -Path $dir_setupexe_odt2013 -Force | Out-Null
    if (-Not (Test-Path -Path "$dir_setupexe_odt2013\setup.exe")) {
        # Del
        Get-ChildItem -Path $dir_setupexe_odt2013 -Recurse | Remove-Item -Recurse -Force
    }

    # Extract ODT2016Plus
    # param
    $app_wgname = "Microsoft.OfficeDeploymentTool"
    $dir_installer = $dir_origfile_odt2016Plus
    $install_args = "`/extract:`"$dir_setupexe_odt2016Plus`" `/quiet"
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
                $url = Get-URL-FromWinget $app_wgname "x64x86"
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
                    Creat-NewEmpty-Folde $dir_origfile_odt2016Plus
                    Write-Host "Manually download latest ODT into Downloads folder"
                    pause
                    Start-Process "https://www.microsoft.com/en-us/download/details.aspx?id=49117"
                    Write-Host "Done?"
                    pause
                    # move
                    Get-ChildItem -Path "$HOME\Downloads" -Filter officedeploymenttool*.exe | ForEach-Object { Move-Item -Path $_.FullName -Destination $dir_origfile_odt2016Plus -Force }

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
        $url = $url_odt_2013
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
