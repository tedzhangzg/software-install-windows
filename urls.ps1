# urls.ps1
# ==================================================
# Description
# ==================================================
# Usage
# ==================================================


# Write-Host "Starting urls.ps1 ..."

# To download and include
# Invoke-Expression $($(Invoke-WebRequest "https://raw.githubusercontent.com/tedzhangzg/scripts/main/urls.ps1" -UseBasicParsing).Content)



# Script to Add Microsoft Store
$url_AddMSStore = "https://github.com/kkkgo/LTSC-Add-MicrosoftStore/archive/refs/heads/master.zip"

# Visual C++ Redistributable
# 
# vlatest
# v2017-2026


# C++ Runtime framework packages for Desktop Bridge
# 
# v14
$url_CPPDB14_a64 = "https://aka.ms/Microsoft.VCLibs.arm64.14.00.Desktop.appx"
$url_CPPDB14_x64 = "https://aka.ms/Microsoft.VCLibs.x64.14.00.Desktop.appx"
$url_CPPDB14_x86 = "https://aka.ms/Microsoft.VCLibs.x86.14.00.Desktop.appx"
# 
# v12
$url_CPPDB12 = "https://download.microsoft.com/download/2/1/F/21F05B77-C444-46C0-B357-7EBC78C95CE2/vc_uwpdesktop.120.exe"
# 
# v11
$url_CPPDB11 = "https://download.microsoft.com/download/3/B/C/3BC60F47-6A7C-4D46-8CFB-C2E746EF336E/vc_uwpdesktop.110.exe"

# NuGet
# Microsoft.UI.Xaml
# $url_NuGetMSUIXaml = "https://www.nuget.org/api/v2/package/Microsoft.UI.Xaml/2.8.7"
# $url_NuGetMSUIXaml = "https://www.nuget.org/api/v2/package/Microsoft.UI.Xaml/2.7.3"

# Windows Package Manager
$url_WinGet = "https://github.com/microsoft/winget-cli/releases/latest/download/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle"

# dot NET
# 
# v6
$url_dotNETHB6 = "https://builds.dotnet.microsoft.com/dotnet/aspnetcore/Runtime/6.0.36/dotnet-hosting-6.0.36-win.exe"
$url_dotNETDR6_a64 = "https://builds.dotnet.microsoft.com/dotnet/WindowsDesktop/6.0.36/windowsdesktop-runtime-6.0.36-win-arm64.exe"
$url_dotNETDR6_x64 = "https://builds.dotnet.microsoft.com/dotnet/WindowsDesktop/6.0.36/windowsdesktop-runtime-6.0.36-win-x64.exe"
$url_dotNETDR6_x86 = "https://builds.dotnet.microsoft.com/dotnet/WindowsDesktop/6.0.36/windowsdesktop-runtime-6.0.36-win-x86.exe"
# 
# v3.1
$url_dotNETHB31 = "https://builds.dotnet.microsoft.com/dotnet/aspnetcore/Runtime/3.1.32/dotnet-hosting-3.1.32-win.exe"
$url_dotNETDR31_x64 = "https://download.visualstudio.microsoft.com/download/pr/b92958c6-ae36-4efa-aafe-569fced953a5/1654639ef3b20eb576174c1cc200f33a/windowsdesktop-runtime-3.1.32-win-x64.exe"
$url_dotNETDR31_x86 = "https://download.visualstudio.microsoft.com/download/pr/3f353d2c-0431-48c5-bdf6-fbbe8f901bb5/542a4af07c1df5136a98a1c2df6f3d62/windowsdesktop-runtime-3.1.32-win-x86.exe"
# 
# v2.1
$url_dotNETHB21 = "https://builds.dotnet.microsoft.com/dotnet/aspnetcore/Runtime/2.1.30/dotnet-hosting-2.1.30-win.exe"

# dot NET Framework
# 
# v4.8.1
$url_dotNETFw481 = "https://go.microsoft.com/fwlink/?linkid=2203305"
# 
# v1.1 and SP1
$url_dotNETFw11_rtm = "https://raw.githubusercontent.com/not001praween001/stockMN-exe/master/stockMN_1.3.1/dotnetfx.exe"
$url_dotNETFw11_sp1 = "https://download.microsoft.com/download/8/b/4/8b4addd8-e957-4dea-bdb8-c4e00af5b94b/NDP1.1sp1-KB867460-X86.exe"

# Visual C++ Redistributable
# 
# v14
$url_VCPP14_a64 = "https://aka.ms/vc14/vc_redist.arm64.exe"
$url_VCPP14_x64 = "https://aka.ms/vc14/vc_redist.x64.exe"
$url_VCPP14_x86 = "https://aka.ms/vc14/vc_redist.x86.exe"
# 
# v2015plus
$url_VCPP2015plus_a64 = "https://download.visualstudio.microsoft.com/download/pr/d7450eb5-03e1-436d-9e7e-deb5fe4759b3/5139E1440C3A20B92153A4DB561C069A0175AAF76C276C3E5B6F56099EDCF4B0/VC_redist.arm64.exe"
$url_VCPP2015plus_x64 = "https://download.visualstudio.microsoft.com/download/pr/73aabf2e-9532-4f68-99f7-3247081a619c/CC0FF0EB1DC3F5188AE6300FAEF32BF5BEEBA4BDD6E8E445A9184072096B713B/VC_redist.x64.exe"
$url_VCPP2015plus_x86 = "https://download.visualstudio.microsoft.com/download/pr/73aabf2e-9532-4f68-99f7-3247081a619c/0C09F2611660441084CE0DF425C51C11E147E6447963C3690F97E0B25C55ED64/VC_redist.x86.exe"
# 
# v2013
$url_VCPP2013_x64 = "https://download.visualstudio.microsoft.com/download/pr/10912041/cee5d6bca2ddbcd039da727bf4acb48a/vcredist_x64.exe"
$url_VCPP2013_x86 = "https://download.visualstudio.microsoft.com/download/pr/10912113/5da66ddebb0ad32ebd4b922fd82e8e25/vcredist_x86.exe"
# 
# v2012
$url_VCPP2012_x64 = "https://download.microsoft.com/download/1/6/B/16B06F60-3B20-4FF2-B699-5E9B7962F9AE/VSU_4/vcredist_x64.exe"
$url_VCPP2012_x86 = "https://download.microsoft.com/download/1/6/B/16B06F60-3B20-4FF2-B699-5E9B7962F9AE/VSU_4/vcredist_x86.exe"
# 
# v2010
$url_VCPP2010_x64 = "https://download.microsoft.com/download/1/6/5/165255E7-1014-4D0A-B094-B6A430A6BFFC/vcredist_x64.exe"
$url_VCPP2010_x86 = "https://download.microsoft.com/download/1/6/5/165255E7-1014-4D0A-B094-B6A430A6BFFC/vcredist_x86.exe"
# 
# v2008
$url_VCPP2008_x64 = "https://download.microsoft.com/download/5/D/8/5D8C65CB-C849-4025-8E95-C3966CAFD8AE/vcredist_x64.exe"
$url_VCPP2008_x86 = "https://download.microsoft.com/download/5/D/8/5D8C65CB-C849-4025-8E95-C3966CAFD8AE/vcredist_x86.exe"
# 
# v2005
$url_VCPP2005_x64 = "https://download.microsoft.com/download/8/B/4/8B42259F-5D70-43F4-AC2E-4B208FD8D66A/vcredist_x64.EXE"
$url_VCPP2005_x86 = "https://download.microsoft.com/download/8/B/4/8B42259F-5D70-43F4-AC2E-4B208FD8D66A/vcredist_x86.EXE"

# Linux kernel update package x64
$url_WSL2Kernel_a64 = "https://wslstorestorage.blob.core.windows.net/wslblob/wsl_update_arm64.msi"
$url_WSL2Kernel_x64 = "https://wslstorestorage.blob.core.windows.net/wslblob/wsl_update_x64.msi"

# Visual Studio Code
$url_VSCode_a64 = "https://code.visualstudio.com/sha/download?build=stable&os=win32-arm64"
$url_VSCode_x64 = "https://code.visualstudio.com/sha/download?build=stable&os=win32-x64"
$url_VSCode_x86 = "https://code.visualstudio.com/sha/download?build=stable&os=win32"

# Windows Essentials 2012
$url_WinEssentials2012 = "https://archive.org/download/wlsetup-all_201802/wlsetup-all.exe"

# TeamViewer QuickSupport v13
$url_TeamViewerQS13 = "https://download.teamviewer.com/download/version_13x/TeamViewerQS.exe"

# Java JRE JDK
$url_Java8_jre_x64 = "https://javadl.oracle.com/webapps/download/GetFile/1.8.0_202-b08/1961070e4c9b4e26a04e7f5a083f551e/windows-i586/jre-8u202-windows-x64.exe"
$url_Java8_jre_x86 = "https://javadl.oracle.com/webapps/download/GetFile/1.8.0_202-b08/1961070e4c9b4e26a04e7f5a083f551e/windows-i586/jre-8u202-windows-i586.exe"
$url_Java10_jre_x64 = "https://javadl.oracle.com/webapps/download/GetFile/10.0.2+13/19aef61b38124481863b1413dce1855f/windows-i586/jre-10.0.2_windows-x64_bin.exe"
$url_Java8_jdk_x64 = "https://javadl.oracle.com/webapps/download/GetFile/1.8.0_202-b08/1961070e4c9b4e26a04e7f5a083f551e/windows-i586/jdk-8u202-windows-x64.exe"
$url_Java8_jdk_x86 = "https://javadl.oracle.com/webapps/download/GetFile/1.8.0_202-b08/1961070e4c9b4e26a04e7f5a083f551e/windows-i586/jdk-8u202-windows-i586.exe"
$url_Java10_jdk_x64 = "https://javadl.oracle.com/webapps/download/GetFile/10.0.2+13/19aef61b38124481863b1413dce1855f/windows-i586/jdk-10.0.2_windows-x64_bin.exe"

# Office 2013 ODT
$url_ODT2013 = "https://download.microsoft.com/download/6/2/3/6230F7A2-D8A9-478B-AC5C-57091B632FCF/officedeploymenttool_x86_5031-1000.exe"

# KMS
$url_msactscript = "https://raw.githubusercontent.com/massgravel/Microsoft-Activation-Scripts/master/MAS/All-In-One-Version-KL/MAS_AIO.cmd"

# Write-Host ""

# Write-Host "Terminating urls.ps1 ..."
# pause


# ==================================================
# Notes
# ==================================================
