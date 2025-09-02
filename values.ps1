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
$appnum_toinclude_WinGet = 1
$appnum_toinclude_enableDevMode = 1
# 
$appnum_toinclude_wincomponentdotNET35 = 1
$appnum_toinclude_wincomponentWSL = 1
$appnum_toinclude_wincomponentVMPlatform = 1
$appnum_toinclude_LinuxKernelUpdate = 1
$appnum_toinclude_wincomponentHypervisorPlatform = 1
$appnum_toinclude_wincomponentHyperV = 1
$appnum_toinclude_wincomponentContainers = 1
$appnum_toinclude_wincomponentNTVDM = 1
$appnum_toinclude_wincomponentDisablePSv2 = 1
$appnum_toinclude_wincomponentRemovePSISE = 1
# 
$appnum_toinclude_dotNET8HB = 1
$appnum_toinclude_dotNET8DRT = 1
$appnum_toinclude_dotNET6HB = 1
$appnum_toinclude_dotNET6DRT = 1
$appnum_toinclude_dotNET31HB = 1
$appnum_toinclude_dotNET31DRT = 1
$appnum_toinclude_dotNET21HB = 1
# 
$appnum_toinclude_dotNET481 = 1
$appnum_toinclude_dotNET11 = 0
# 
$appnum_toinclude_vcpp2005 = 1
$appnum_toinclude_vcpp2008 = 1
$appnum_toinclude_vcpp2010 = 1
$appnum_toinclude_vcpp2012 = 1
$appnum_toinclude_vcpp2013 = 1
$appnum_toinclude_vcpp2015plus = 1
# 
$appnum_toinclude_cppdb11 = 1
$appnum_toinclude_cppdb12 = 1
# 
$appnum_toinclude_Python3 = 1
$appnum_toinclude_Python2 = 0
# 
$appnum_toinclude_SublimeText = 0
##################################################
$appnum_toinclude_RestartMidway = 1
##################################################
$appnum_toinclude_PowerShell = 1
$appnum_toinclude_WinTerminal = 1
$appnum_toinclude_VSCode = 1
$appnum_toinclude_WSL = 0
# 
$appnum_toinclude_iTunes = 0
# 
$appnum_toinclude_Edge = 0
$appnum_toinclude_Teams = 1
$appnum_toinclude_Skype = 0
$appnum_toinclude_WinEssentials = 1
# 
$appnum_toinclude_Chrome = 1
$appnum_toinclude_Drive = 1
# 
$appnum_toinclude_Messenger = 0
# 
$appnum_toinclude_AcrobatReader = 1
# 
$appnum_toinclude_Dropbox = 0
# 
$appnum_toinclude_Zoom = 1
$appnum_toinclude_Discord = 0
$appnum_toinclude_Telegram = 1
$appnum_toinclude_WhatsApp = 1
$appnum_toinclude_WeChat = 0
# 
$appnum_toinclude_TeamViewer = 1
$appnum_toinclude_SevenZip = 1
$appnum_toinclude_WinRAR = 0
$appnum_toinclude_VLC = 1
$appnum_toinclude_Java8 = 0
$appnum_toinclude_OpenVPN = 0
$appnum_toinclude_WireGuard = 0
$appnum_toinclude_Firefox = 1
$appnum_toinclude_Thunderbird = 0
$appnum_toinclude_OBS = 0
$appnum_toinclude_LibreOffice = 0
# 
$appnum_toinclude_Office = 1
##################################################
# Evaluated values
# Do not touch
# $appnum_toinclude_LibreOffice = (&{If($appnum_toinclude_MSOffice) {0} Else {1}})
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
