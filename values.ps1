# values.ps1
# ==================================================
# Description
# ==================================================
# Usage
# This file contains values to be used in the script
# Do not change the structure of the file
# Do not change the comments
# Do not change the variable names
# Do not change the values before the equal sign
# Only change the values after the equal sign
# ==================================================


# Write-Host "Starting values.ps1 ..."

# Instructions
##################################################
# ONLY change values after = sign
# DO NOT change other words / symbols
# SAVE changes and close notepad
##################################################



# Include/Exclude specific apps during installation
# These will only affect installation if app is in range of "from" and "to" in Script1
##################################################
# IMPORTANT
# Do not leave blank, put either 1 or 0
##################################################
# Documentation
# 1 --> include
# 0 --> exclude
##################################################
# Try not to touch these few important apps
##################################################
$app_toinclude_WinGet = 1
$app_toinclude_EnableDevMode = 1
# 
$app_toinclude_NetFx3 = 1
$app_toinclude_MicrosoftWindowsSubsystemLinux = 1
$app_toinclude_VirtualMachinePlatform = 1
$app_toinclude_WSL2Kernel = 1
$app_toinclude_HypervisorPlatform = 1
$app_toinclude_MicrosoftHyperV = 1
$app_toinclude_Containers = 1
$app_toinclude_NTVDM = 1
$app_toinclude_MicrosoftWindowsPowerShellV2Root = 1
$app_toinclude_PowerShellISE = 1
# 
$app_toinclude_dotNETHB10 = 1
$app_toinclude_dotNETDR10 = 1
$app_toinclude_dotNETHB8 = 1
$app_toinclude_dotNETDR8 = 1
$app_toinclude_dotNETHB6 = 1
$app_toinclude_dotNETDR6 = 1
$app_toinclude_dotNETHB31 = 0
$app_toinclude_dotNETDR31 = 0
$app_toinclude_dotNETHB21 = 0
# 
$app_toinclude_dotNETFw481 = 0
$app_toinclude_dotNETFw11 = 0
# 
$app_toinclude_VCPP2005 = 1
$app_toinclude_VCPP2008 = 1
$app_toinclude_VCPP2010 = 1
$app_toinclude_VCPP2012 = 1
$app_toinclude_VCPP2013 = 1
$app_toinclude_VCPP2015plus = 1
$app_toinclude_VCPP14 = 1
# 
$app_toinclude_CPPDB11 = 1
$app_toinclude_CPPDB12 = 1
$app_toinclude_CPPDB14 = 1
# 
$app_toinclude_Python3 = 1
$app_toinclude_Python2 = 0
# 
$app_toinclude_SublimeText = 0
##################################################
$app_toinclude_RestartMidway = 1
##################################################
$app_toinclude_PowerShell = 1
$app_toinclude_WinTerminal = 1
$app_toinclude_VSCode = 1
$app_toinclude_WSL = 0
# 
$app_toinclude_iTunes = 0
# 
$app_toinclude_Edge = 0
$app_toinclude_Teams = 1
$app_toinclude_Skype = 0
$app_toinclude_WinEssentials2012 = 1
# 
$app_toinclude_Chrome = 1
$app_toinclude_Drive = 1
# 
$app_toinclude_Messenger = 0
# 
$app_toinclude_AcrobatReader = 1
# 
$app_toinclude_Dropbox = 0
# 
$app_toinclude_Zoom = 1
$app_toinclude_Discord = 0
$app_toinclude_Telegram = 1
$app_toinclude_WhatsApp = 1
$app_toinclude_WeChat = 0
# 
$app_toinclude_TeamViewerLatest = 1
$app_toinclude_TeamViewerQS13 = 1
$app_toinclude_SevenZip = 1
$app_toinclude_WinRAR = 0
$app_toinclude_VLC = 1
$app_toinclude_Java8 = 0
$app_toinclude_OpenVPN = 0
$app_toinclude_WireGuard = 0
$app_toinclude_Firefox = 1
$app_toinclude_Thunderbird = 0
$app_toinclude_OBS = 0
$app_toinclude_LibreOffice = 0
# 
$app_toinclude_MSOffice = 1
##################################################
# Evaluated values
# Do not touch
# $app_toinclude_LibreOffice = (&{If($app_toinclude_MSOffice) {0} Else {1}})
##################################################


# Set Microsoft Office version, bit, language
##################################################
# IMPORTANT
# If unsure, use 0, do not leave blank
##################################################
# Documentation
# 
# msoffice_sku_num (dependent on msoffice_ver_num, but for latest, it is ...)
# 18 -> ProPlus2024Volume
# 19 -> Standard2024Volume
# 20 -> ProjectPro2024Volume
# 22 -> VisioPro2024Volume
# 
# msoffice_bit
# 64 -> 64-bit
# 32 -> 32-bit
# 
# msoffice_lang_num
# 3 -> en-US
# 5 -> enter language manually later
##################################################
# if unsure --> use 0, not blank
# 
$msoffice_ver_num = 2024
$msoffice_sku_num = 19
$msoffice_bit = 64
$msoffice_lang_num = 3
##################################################
# 1 --> to add to exclude list --> will NOT be installed
# 0 --> to remove from exclude list --> will be installed
# 
$msoffice_exclude_Access = 0
$msoffice_exclude_Bing = 1
$msoffice_exclude_Excel = 0
$msoffice_exclude_Groove = 1
$msoffice_exclude_Lync = 1
$msoffice_exclude_OneDrive = 1
$msoffice_exclude_OneNote = 0
$msoffice_exclude_Outlook = 0
$msoffice_exclude_OutlookForWindows = 0
$msoffice_exclude_PowerPoint = 0
$msoffice_exclude_Publisher = 1
$msoffice_exclude_Teams = 1
$msoffice_exclude_Word = 0
##################################################

# Write-Host ""

# Write-Host "Terminating values.ps1 ..."
# pause


# ==================================================
# Notes
# ==================================================
