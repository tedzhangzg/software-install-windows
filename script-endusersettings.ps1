# script-endusersettings.ps1
# ==================================================
# Description
# Settings for end user
# ==================================================
# Usage
# Run this script after the installation of Windows 10/11
# ==================================================


Write-Host "Starting script-endusersettings.ps1 ..."

# include
. ".\functions.ps1"
. ".\urls.ps1"
. ".\values.ps1"

# var
# $var = ""

Write-Host ""
Write-Host "================================================================================"
Write-Host "Script - All config"
Write-Host "================================================================================"
Write-Host ""

# Pin to Start -> Layout
Write-Host "Pin to Start -> Layout"
Write-Host "Terminal"
Write-Host "TeamViewerQS"

pause
Write-Host ""


# Pin to Taskbar -> Layout
Write-Host "Pin to Taskbar -> Layout"
Write-Host "FileExplorer"
Write-Host "Edge"
Write-Host "VLC"
Write-Host "Office - Word Excel PowerPoint Outlook"
Write-Host "Teams"
Write-Host "MovieMaker"
Write-Host "Zoom"
Write-Host "Chrome"

pause
Write-Host ""


# Time & Language -> Date & time
Write-Host "Time & Language -> Date & time"
Write-Host "Time zone"
Write-Host "Sync now"
start ms-settings:dateandtime

pause
Write-Host ""


# Time & Language -> Language
Write-Host "Time & Language -> Language"
Write-Host "Preferred languages - add remove"
start ms-settings:regionlanguage

pause
Write-Host ""


# Personalization -> Themes
Write-Host "Personalization -> Themes"
start ms-settings:themes
# cmd.exe /c "explorer.exe shell:::{ED834ED6-4B5A-4bfe-8F11-A626DCB6A921}"
# Show-ControlPanelItem -CanonicalName "Microsoft.Personalization"

pause
Write-Host ""


# FileExplorer -> Layout
Write-Host "FileExplorer -> Layout"
Write-Host "Maximise"
Write-Host "Show Ribbon (Win10)"
explorer.exe

pause
Write-Host ""


# ControlPanel -> Layout
Write-Host "ControlPanel -> Layout"
Write-Host "Maximise"
control.exe

pause
Write-Host ""


# File Explorer Options -> View
Write-Host "File Explorer Options -> View"
Write-Host "Reset Folders"
Write-Host "Restore Defaults"
rundll32.exe shell32.dll,Options_RunDLL 7
# Show-ControlPanelItem -CanonicalName "Microsoft.FolderOptions"

pause
Write-Host ""

# File Explorer Options -> View
Write-Host "File Explorer Options -> View"
# 01 - Files and Folders -> Always show menus
New-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "AlwaysShowMenus" -PropertyType "DWORD" -Value 1 -Force | Out-Null
# 02 - Files and Folders -> Display the full path in the title bar
New-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CabinetState" -Name "FullPath" -PropertyType "DWORD" -Value 1 -Force | Out-Null
# 03 - Files and Folders -> Hidden files and folders -> Show hidden files, folders, and drives
New-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "Hidden" -PropertyType "DWORD" -Value 1 -Force | Out-Null
# 04 - Files and Folders -> Hide empty drives
New-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "HideDrivesWithNoMedia" -PropertyType "DWORD" -Value 0 -Force | Out-Null
# 05 - Files and Folders -> Hide extensions for known file types
New-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "HideFileExt" -PropertyType "DWORD" -Value 0 -Force | Out-Null
# 06 - Files and Folders -> Hide folder merge conflicts
New-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "HideMergeConflicts" -PropertyType "DWORD" -Value 0 -Force | Out-Null
# 07 - Files and Folders -> Launch folder windows in a separate process
New-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "SeparateProcess" -PropertyType "DWORD" -Value 1 -Force | Out-Null
# 08 - Files and Folders -> Restore previous folder windows at logon
New-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "PersistBrowsers" -PropertyType "DWORD" -Value 1 -Force | Out-Null
# 09 - Files and Folders -> Show encrypted or compressed NTFS files in color
New-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ShowEncryptCompressedColor" -PropertyType "DWORD" -Value 1 -Force | Out-Null
# 10 - Files and Folders -> Use check boxes to select items
New-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "AutoCheckSelect" -PropertyType "DWORD" -Value 1 -Force | Out-Null
# Navigation Pane ->
# Restart Explorer
Stop-Process -ProcessName explorer

pause
Write-Host ""


# Internet -> Settings
Write-Host "Internet -> Settings"

#IE
# Change Start Page
New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Internet Explorer\Main" -Name "Start Page" -PropertyType "STRING" -Value "https://www.google.com/" -Force | Out-Null
New-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Internet Explorer\Main" -Name "Start Page" -PropertyType "STRING" -Value "https://www.google.com/" -Force | Out-Null
# Show-ControlPanelItem -CanonicalName "Microsoft.InternetOptions"
# Change search engine to Google
# Step 1
$newValue = "{" + ([Guid]::NewGuid()).Guid.ToUpper() + "}"
New-Item -Path "HKCU:\SOFTWARE\Microsoft\Internet Explorer\SearchScopes" -Force | Out-Null
New-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Internet Explorer\SearchScopes" -Name "DefaultScope" -PropertyType "String" -Value $newValue -Force | Out-Null
# Step 2a
New-Item -Path "HKCU:\SOFTWARE\Microsoft\Internet Explorer\SearchScopes\$newValue" -Force | Out-Null
# Step 2b
New-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Internet Explorer\SearchScopes\$newValue" -Name "DisplayName" -PropertyType "String" -Value "Google" -Force | Out-Null
New-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Internet Explorer\SearchScopes\$newValue" -Name "FaviconURL" -PropertyType "String" -Value "http://www.google.com/favicon.ico" -Force | Out-Null
New-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Internet Explorer\SearchScopes\$newValue" -Name "ShowSearchSuggestions" -PropertyType "DWORD" -Value 1 -Force | Out-Null
New-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Internet Explorer\SearchScopes\$newValue" -Name "SuggestionsURL" -PropertyType "String" -Value "http://clients5.google.com/complete/search?q={searchTerms}&client=ie8&mw={ie:maxWidth}&sh={ie:sectionHeight}&rh={ie:rowHeight}&inputencoding={inputEncoding}&outputencoding={outputEncoding}" -Force | Out-Null
New-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Internet Explorer\SearchScopes\$newValue" -Name "URL" -PropertyType "String" -Value "http://www.google.com/search?q={searchTerms}" -Force | Out-Null
# Disable first run
New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Internet Explorer\Main" -Force | Out-Null
New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Internet Explorer\Main" -Name "DisableFirstRunCustomize" -PropertyType "DWORD" -Value 1 -Force | Out-Null

# Edge
# Disable first run
New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Edge" -Force | Out-Null
New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Edge" -Name "HideFirstRunExperience" -PropertyType "DWORD" -Value 1 -Force | Out-Null

pause
Write-Host ""


# Network and Sharing Center -> Change advanced sharing settings
Write-Host "Network and Sharing Center -> Change advanced sharing settings"
Write-Host ""
# Any -> Network discovery
Set-NetFirewallRule -DisplayGroup "Network Discovery" -Enabled True -Profile "Any" | Out-Null
# Any -> File and printer sharing
Set-NetFirewallRule -DisplayGroup "File And Printer Sharing" -Enabled True -Profile "Any" | Out-Null
# All Networks -> Public folder sharing
Write-Host "Change advanced sharing settings"
Write-Host "Public folder sharing"
cmd.exe /c "explorer.exe shell:::{8E908FC9-BECC-40f6-915B-F4CA0E70D03D}\Advanced"
# Show-ControlPanelItem -CanonicalName "Microsoft.NetworkAndSharingCenter"

pause
Write-Host ""


# Personalization -> Start
Write-Host "Personalization -> Start"
start ms-settings:personalization-start
# rundll32.exe shell32.dll,Options_RunDLL 3

pause
Write-Host ""


# Taskbar -> Layout
Write-Host "Taskbar -> Layout"
# Taskbar -> Search -> Show search icon
New-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" -Name "SearchboxTaskbarMode" -PropertyType "DWORD" -Value 1 -Force | Out-Null
# Taskbar -> News and interests -> Turn off
New-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Feeds" -Name "ShellFeedsTaskbarViewMode" -PropertyType "DWORD" -Value 2 -Force | Out-Null
# Restart Explorer
Stop-Process -ProcessName explorer

pause
Write-Host ""


# WindowsDefender -> Layout
Write-Host "WindowsDefender -> Layout"
Write-Host "Maximise"
Write-Host "App & browser control -> Reputation-based protection settings -> Potentially unwanted app blocking"
start windowsdefender:

pause
Write-Host ""


# Notification -> Layout
Write-Host "Notification -> Layout"
start ms-settings:notifications
"Clear all notifications"

pause
Write-Host ""


# Registry Settings
Write-Host "Registry Settings ..."
# First login animation
# Documentation
# https://docs.microsoft.com/en-us/windows/client-management/mdm/policy-csp-windowslogon
# Key1 - Default
New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" -Name "EnableFirstLogonAnimation" -PropertyType "DWORD" -Value 0 -Force | Out-Null
# Key2 - GroupPolicy
New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "EnableFirstLogonAnimation" -PropertyType "DWORD" -Value 0 -Force | Out-Null
# Privacy notice
New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\OOBE" -Force | Out-Null
New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\OOBE" -Name "DisablePrivacyExperience" -PropertyType "DWORD" -Value 1 -Force | Out-Null

pause
Write-Host ""


# Running Programs
Write-Host "Running Programs ..."
Write-Host ""
# All
# Browsers
# MicrosoftServices
# GoogleServices
# VLC
# Adobe
# Zoom
# Office
# Other
Write-Host ""

# IE
Write-Host "Running IE ..."
Start-Process -FilePath "iexplore"
pause
Write-Host "Internet Options -> Programs -> Manage add-ons -> Learn more about toolbars and extensions"
Show-ControlPanelItem -CanonicalName "Microsoft.InternetOptions"
pause

Write-Host ""

# Edge
Write-Host "Running Edge ..."
Start-Process -FilePath "msedge"
pause
Write-Host ""

# Chrome
Write-Host "Running Chrome ..."
Start-Process -FilePath "chrome"
pause
Write-Host ""

# Firefox
Write-Host "Running Firefox ..."
Start-Process -FilePath "firefox"
pause
Write-Host ""
# Close, Run again
Write-Host "Running Firefox, again ..."
Start-Process -FilePath "firefox"
pause
Write-Host ""

# Teams
Write-Host "Running Teams ..."
Start-Process -FilePath "$env:LOCALAPPDATA\Microsoft\Teams\Update.exe" -ArgumentList "--processStart `"Teams.exe`""
pause
Write-Host ""

# MovieMaker
Write-Host "Running MovieMaker ..."
Start-Process -FilePath "moviemaker"
pause
Write-Host ""

# PhotoGallery
Write-Host "Running PhotoGallery ..."
Start-Process -FilePath "wlxphotogallery"
pause
Write-Host ""

# VLC
Write-Host "Running VLC ..."
Start-Process -FilePath "vlc"
pause
Write-Host ""

# AcrobatReader
Write-Host "Running AcrobatReader ..."
Start-Process -FilePath "acrobat"
pause
Write-Host ""

# Zoom
Write-Host "Running Zoom ..."
Start-Process -FilePath "$env:ProgramFiles\Zoom\bin\Zoom.exe"
# Start-Process -FilePath "$env:AppData\Zoom\bin\Zoom.exe"
pause
Write-Host ""

# Word
Write-Host "Running Word ..."
Start-Process -FilePath "winword"
pause
Write-Host ""

# Check Windows Activation
Write-Host "Check Windows Activation"
start ms-settings:activation
# Get-CimInstance -ClassName "SoftwareLicensingProduct" -Filter "Name like 'Windows%'" | ? { $_.PartialProductKey } | Select Description, LicenseStatus
pause
Write-Host ""


Write-Host "Check: any other apps, do manually"
pause
Write-Host ""


# Set Default Programs
Write-Host "Set Default Programs"
Write-Host "Chrome - Web Email"
Write-Host "VLC - Music Video Photo"
Write-Host "Run - 7-zip"
Write-Host "Set defaults by app - Adobe Chrome VLC(optional)"
start ms-settings:defaultapps
# control /name Microsoft.DefaultPrograms /page pageDefaultProgram
# Show-ControlPanelItem -CanonicalName "Microsoft.DefaultPrograms"

pause
Write-Host ""


# Disable App Startup
Write-Host "Disable App Startup"
start ms-settings:startupapps

pause
Write-Host ""


# Security and Maintenance -> Change Security and Maintenance settings
Write-Host "Security and Maintenance"
Write-Host "Change Security and Maintenance settings"
Write-Host "Uncheeck all"
cmd.exe /c "explorer.exe shell:::{BB64F8A7-BEE7-4E1A-AB8D-7D8273F7FDB6}\Settings"
# Show-ControlPanelItem -CanonicalName "Microsoft.ActionCenter"

pause
Write-Host ""


# File Explorer Options -> General
Write-Host "File Explorer Options -> General"
Write-Host "Clear"
Show-ControlPanelItem -CanonicalName "Microsoft.FolderOptions"

pause
Write-Host ""


# Delete Files
Write-Host "Delete Files"
Write-Host "Temp"
Write-Host "C root"
Invoke-Item -Path $env:TEMP
Invoke-Item -Path "$env:SystemRoot\Temp"
Invoke-Item -Path "$env:SystemDrive\"

pause
Write-Host ""


# User Accounts Settings
Write-Host "User Accounts Settings"
# Show-ControlPanelItem -CanonicalName "Microsoft.UserAccounts"

# pause

Write-Host ""

# final

Invoke-Item -Path ..

Clear-PSHistory

Write-Host ""

Write-Host "Terminating script-endusersettings.ps1 ..."
pause


# ==================================================
# Notes
# ==================================================
