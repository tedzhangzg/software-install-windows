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
$url_addmsstore = "https://github.com/kkkgo/LTSC-Add-MicrosoftStore/archive/refs/heads/master.zip"

# C++ Runtime framework packages for Desktop Bridge
# 
# v14
$url_cppdb_14_a64 = "https://aka.ms/Microsoft.VCLibs.arm64.14.00.Desktop.appx"
$url_cppdb_14_x64 = "https://aka.ms/Microsoft.VCLibs.x64.14.00.Desktop.appx"
$url_cppdb_14_x86 = "https://aka.ms/Microsoft.VCLibs.x86.14.00.Desktop.appx"
# 
# v12
$url_cppdb_12_x86 = "https://download.microsoft.com/download/2/1/F/21F05B77-C444-46C0-B357-7EBC78C95CE2/vc_uwpdesktop.120.exe"
# 
# v11
$url_cppdb_11_x86 = "https://download.microsoft.com/download/3/B/C/3BC60F47-6A7C-4D46-8CFB-C2E746EF336E/vc_uwpdesktop.110.exe"

# NuGet
# Microsoft.UI.Xaml
# $url_nuget_msuixaml = "https://www.nuget.org/api/v2/package/Microsoft.UI.Xaml/2.8.7"
# $url_nuget_msuixaml = "https://www.nuget.org/api/v2/package/Microsoft.UI.Xaml/2.7.3"

# Windows Package Manager
$url_winget = "https://github.com/microsoft/winget-cli/releases/latest/download/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle"

# dot NET
# 
# v6
$url_dotnet6HB = "https://builds.dotnet.microsoft.com/dotnet/aspnetcore/Runtime/6.0.36/dotnet-hosting-6.0.36-win.exe"
$url_dotnet6DRT_a64 = "https://builds.dotnet.microsoft.com/dotnet/WindowsDesktop/6.0.36/windowsdesktop-runtime-6.0.36-win-arm64.exe"
$url_dotnet6DRT_x64 = "https://builds.dotnet.microsoft.com/dotnet/WindowsDesktop/6.0.36/windowsdesktop-runtime-6.0.36-win-x64.exe"
$url_dotnet6DRT_x86 = "https://builds.dotnet.microsoft.com/dotnet/WindowsDesktop/6.0.36/windowsdesktop-runtime-6.0.36-win-x86.exe"
# 
# v3.1
$url_dotnet31HB = "https://builds.dotnet.microsoft.com/dotnet/aspnetcore/Runtime/3.1.32/dotnet-hosting-3.1.32-win.exe"
$url_dotnet31DRT_x64 = "https://download.visualstudio.microsoft.com/download/pr/b92958c6-ae36-4efa-aafe-569fced953a5/1654639ef3b20eb576174c1cc200f33a/windowsdesktop-runtime-3.1.32-win-x64.exe"
$url_dotnet31DRT_x86 = "https://download.visualstudio.microsoft.com/download/pr/3f353d2c-0431-48c5-bdf6-fbbe8f901bb5/542a4af07c1df5136a98a1c2df6f3d62/windowsdesktop-runtime-3.1.32-win-x86.exe"
# 
# v2.1
$url_dotnet21HB = "https://builds.dotnet.microsoft.com/dotnet/aspnetcore/Runtime/2.1.30/dotnet-hosting-2.1.30-win.exe"

# dot NET Framework
# 
# v4.8.1
$url_dotnetfw_481 = "https://go.microsoft.com/fwlink/?linkid=2203305"
# 
# v1.1 and SP1
$url_dotnetfw_11rtm = "https://raw.githubusercontent.com/not001praween001/stockMN-exe/master/stockMN_1.3.1/dotnetfx.exe"
$url_dotnetfw_11sp1 = "https://download.microsoft.com/download/8/b/4/8b4addd8-e957-4dea-bdb8-c4e00af5b94b/NDP1.1sp1-KB867460-X86.exe"

# Visual C++ Redistributable
# 
# v2015+
$url_vcpp_2015Plus_a64 = "https://aka.ms/vs/17/release/vc_redist.arm64.exe"
$url_vcpp_2015Plus_x64 = "https://aka.ms/vs/17/release/vc_redist.x64.exe"
$url_vcpp_2015Plus_x86 = "https://aka.ms/vs/17/release/vc_redist.x86.exe"
# 
# v2013
$url_vcpp_2013_x64 = "https://aka.ms/highdpimfc2013x64enu"
$url_vcpp_2013_x86 = "https://aka.ms/highdpimfc2013x86enu"
# 
# v2012
$url_vcpp_2012_x64 = "https://download.microsoft.com/download/1/6/B/16B06F60-3B20-4FF2-B699-5E9B7962F9AE/VSU_4/vcredist_x64.exe"
$url_vcpp_2012_x86 = "https://download.microsoft.com/download/1/6/B/16B06F60-3B20-4FF2-B699-5E9B7962F9AE/VSU_4/vcredist_x86.exe"
# 
# v2010
$url_vcpp_2010_x64 = "https://download.microsoft.com/download/1/6/5/165255E7-1014-4D0A-B094-B6A430A6BFFC/vcredist_x64.exe"
$url_vcpp_2010_x86 = "https://download.microsoft.com/download/1/6/5/165255E7-1014-4D0A-B094-B6A430A6BFFC/vcredist_x86.exe"
# 
# v2008
$url_vcpp_2008_x64 = "https://download.microsoft.com/download/5/D/8/5D8C65CB-C849-4025-8E95-C3966CAFD8AE/vcredist_x64.exe"
$url_vcpp_2008_x86 = "https://download.microsoft.com/download/5/D/8/5D8C65CB-C849-4025-8E95-C3966CAFD8AE/vcredist_x86.exe"
# 
# v2005
$url_vcpp_2005_x64 = "https://download.microsoft.com/download/8/B/4/8B42259F-5D70-43F4-AC2E-4B208FD8D66A/vcredist_x64.EXE"
$url_vcpp_2005_x86 = "https://download.microsoft.com/download/8/B/4/8B42259F-5D70-43F4-AC2E-4B208FD8D66A/vcredist_x86.EXE"

# Linux kernel update package x64
$url_wsl2kernel_a64 = "https://wslstorestorage.blob.core.windows.net/wslblob/wsl_update_arm64.msi"
$url_wsl2kernel_x64 = "https://wslstorestorage.blob.core.windows.net/wslblob/wsl_update_x64.msi"

# Visual Studio Code
$url_vscode_a64 = "https://code.visualstudio.com/sha/download?build=stable&os=win32-arm64"
$url_vscode_x64 = "https://code.visualstudio.com/sha/download?build=stable&os=win32-x64"
$url_vscode_x86 = "https://code.visualstudio.com/sha/download?build=stable&os=win32"

# Windows Essentials 2012
$url_winessentials_2012 = "https://archive.org/download/wlsetup-all_201802/wlsetup-all.exe"

# TeamViewer QuickSupport v13
$url_teamviewerqs_13 = "https://download.teamviewer.com/download/version_13x/TeamViewerQS.exe"

# Java JRE JDK
$url_javajre_8_x64 = "https://javadl.oracle.com/webapps/download/GetFile/1.8.0_202-b08/1961070e4c9b4e26a04e7f5a083f551e/windows-i586/jre-8u202-windows-x64.exe"
$url_javajre_8_x86 = "https://javadl.oracle.com/webapps/download/GetFile/1.8.0_202-b08/1961070e4c9b4e26a04e7f5a083f551e/windows-i586/jre-8u202-windows-i586.exe"
$url_javajre_10_x64 = "https://javadl.oracle.com/webapps/download/GetFile/10.0.2+13/19aef61b38124481863b1413dce1855f/windows-i586/jre-10.0.2_windows-x64_bin.exe"
$url_javajdk_8_x64 = "https://javadl.oracle.com/webapps/download/GetFile/1.8.0_202-b08/1961070e4c9b4e26a04e7f5a083f551e/windows-i586/jdk-8u202-windows-x64.exe"
$url_javajdk_8_x86 = "https://javadl.oracle.com/webapps/download/GetFile/1.8.0_202-b08/1961070e4c9b4e26a04e7f5a083f551e/windows-i586/jdk-8u202-windows-i586.exe"
$url_javajdk_10_x64 = "https://javadl.oracle.com/webapps/download/GetFile/10.0.2+13/19aef61b38124481863b1413dce1855f/windows-i586/jdk-10.0.2_windows-x64_bin.exe"

# Office 2013 ODT
$url_odt_2013 = "https://download.microsoft.com/download/6/2/3/6230F7A2-D8A9-478B-AC5C-57091B632FCF/officedeploymenttool_x86_5031-1000.exe"

# Microsoft Access Database Engine
$url_msaccessdbengine_2010_x64 = "https://download.microsoft.com/download/2/4/3/24375141-E08D-4803-AB0E-10F2E3A07AAA/AccessDatabaseEngine_X64.exe"
$url_msaccessdbengine_2010_x86 = "https://download.microsoft.com/download/2/4/3/24375141-E08D-4803-AB0E-10F2E3A07AAA/AccessDatabaseEngine.exe"
$url_msaccessdbengine_2016_x64 = "https://download.microsoft.com/download/3/5/C/35C84C36-661A-44E6-9324-8786B8DBE231/accessdatabaseengine_X64.exe"
$url_msaccessdbengine_2016_x86 = "https://download.microsoft.com/download/3/5/C/35C84C36-661A-44E6-9324-8786B8DBE231/accessdatabaseengine.exe"

# KMS
$url_msactscript = "https://raw.githubusercontent.com/massgravel/Microsoft-Activation-Scripts/master/MAS/All-In-One-Version-KL/MAS_AIO.cmd"
$url_convr2v = "https://raw.githubusercontent.com/abbodi1406/C2R-R2V-AIO/master/C2R-R2V-AIO.cmd"

# Write-Host ""

# Write-Host "Terminating urls.ps1 ..."
# pause


# ==================================================
# Notes
# ==================================================
