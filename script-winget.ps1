# script-winget.ps1
# ==================================================
# Description
# This script checks for the installation of WinGet
# and installs it if not present. It also installs
# necessary prerequisites such as the C++ Desktop
# Bridge and NuGet packages.
# ==================================================
# Usage
# Run this script in a PowerShell environment with
# administrative privileges to ensure proper installation
# of WinGet and its dependencies.
# ==================================================


Write-Host "Starting script-winget.ps1 ..."

# include
. ".\functions.ps1"
. ".\urls.ps1"
. ".\values.ps1"

# var
# $var = ""

# Change Colours
Clear-Host
$host.UI.RawUI.BackgroundColor = "DarkGreen"
# $host.UI.RawUI.ForegroundColor = "DarkYellow"
Clear-Host

Write-Host ""
Write-Host "================================================================================"
Write-Host "Script - Check and Install WinGet"
Write-Host "================================================================================"
Write-Host ""


# Create temp folder
$tmp_dir = "$env:TEMP\tempappdlinst"
Creat-NewEmpty-Folde $tmp_dir


Write-Host ""
Write-Host ""


# Define Functions

Function Instal-WinGe-Prereq() {

    # C++ Desktop Bridge 14 x86
    # Param
    $url_appspecific = $url_cppdb_14_x86
    $dir_installer = "VCPP_CPPDB14" + "x86"
    $install_args = ""
    # Install/Download/Execute
    # Download
    if (-Not (Test-Path -Path $dir_installer)) {
        $url = $url_appspecific
        Downloa-Installe $url $dir_installer
    }
    # Install
    Instal-Ap $dir_installer $install_args

    # C++ Desktop Bridge 14 x64
    if ([Environment]::Is64BitOperatingSystem) {
        # Param
        $url_appspecific = $url_cppdb_14_x64
        $dir_installer = "VCPP_CPPDB14" + "x64"
        $install_args = ""
        # Install/Download/Execute
        # Download
        if (-Not (Test-Path -Path $dir_installer)) {
            $url = $url_appspecific
            Downloa-Installe $url $dir_installer
        }
        Instal-Ap $dir_installer $install_args
    }

    # NuGet Microsoft.UI.Xaml
    # Param
    $url_appspecific = $url_nuget_msuixaml
    $dir_installer = "NuGetMSUIXaml"
    $install_args = ""
    # Install/Download/Execute
    # Download
    if (-Not (Test-Path -Path $dir_installer)) {
        $url = $url_appspecific
        Downloa-Installe $url $dir_installer
        Get-ChildItem -Path $dir_installer | Rename-Item -NewName "microsoft.ui.xaml._ver_.zip"
    }
    # Extract
    Expand-Archive -Path "$dir_installer\microsoft.ui.xaml._ver_.zip" -DestinationPath "$dir_installer\microsoft.ui.xaml._ver_"
    # Install
    $dir_installer = "$dir_installer\microsoft.ui.xaml._ver_\tools\AppX\x64\Release"
    $install_args = ""
    Instal-Ap $dir_installer $install_args

}

Function Instal-WinGe-Proper-Auto() {
    # Param
    $url_appspecific = $url_winget
    $dir_installer = "WinGet"
    $install_args = ""
    # Install/Download/Execute
    # Download
    if (-Not (Test-Path -Path $dir_installer)) {
        $url = $url_appspecific
        Downloa-Installe $url $dir_installer
    }
    Instal-Ap $dir_installer $install_args
}

Function Instal-WinGe-Proper-Manual() {
    # WinGet
    Write-Host "Do this - Manual install"
    Write-Host "##############################"
    Write-Host "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
    Write-Host "Double-click on file in the window that just opened"
    Write-Host "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
    Write-Host "##############################"
    Invoke-Item -Path "WinGet"
    Write-Host ""
    Write-Host ""
    Write-Host ""
    Write-Host "Done?"
    pause
}


# Run
Instal-WinGe-Prereq
Instal-WinGe-Proper-Auto

try {
    # Check
    winget search --id "Google.Chrome" --accept-source-agreements
} catch {
    # Install manually
    Write-Host ""
    Write-Host ""
    Write-Host ""
    Write-Host "##################################################"
    Write-Host "IMPORTANT!!! - Failed to auto install"
    Write-Host "##################################################"
    Write-Host ""
    Instal-WinGe-Proper-Manual
}

Write-Host ""

Write-Host "Terminating script-winget.ps1 ..."
# pause


# ==================================================
# Notes
# ==================================================
