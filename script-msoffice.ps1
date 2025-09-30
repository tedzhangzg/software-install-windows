# script-msoffice.ps1
# ==================================================
# Description
# This script installs Microsoft Office using the Office Deployment Tool (ODT).
# It allows for online installation, offline installation, or downloading the installation files.
# It supports various versions of Office, including Office 365, 2024, 2021, 2019, 2016, and 2013.
# The script also allows for customization of the installation, such as selecting the SKU, bit version
# and language.
# It can exclude specific Office applications from the installation.
# ==================================================
# Usage
# Run the script in PowerShell with administrative privileges.
# Follow the prompts to select the installation mode, Office version, SKU, bit version, and
# language.
# The script will create an XML configuration file for the Office Deployment Tool and execute it.
# It will also copy relevant shortcuts to the desktop for easy access.
# ==================================================


Write-Host "Starting script-msoffice.ps1 ..."

# include
. ".\functions.ps1"
. ".\urls.ps1"
. ".\values.ps1"

# var
# $var = ""

Write-Host ""
Write-Host "================================================================================"
Write-Host "Script - Install Microsoft Office"
Write-Host "================================================================================"
Write-Host ""

# Office SKU Hash Table and Array

# List of Office version numbers
$list_office_versionnumber = @("365" , "2024" , "2021" , "2019" , "2016" , "2013" , "2010" , "2007" , "2003" , "2002" , "2000" , "1997" , "1995")

# Office 365
$hashtabl_office365 = [ordered]@{
    "O365ProPlusRetail" = "Current"
    "O365BusinessRetail" = "Current"
    "O365HomePremRetail" = "Current"
}
$arra_office365 = @()
$hashtabl_office365.keys | ForEach-Object { $arra_office365 += $_ }
# Notes
# Options 1-4 will install these respectively
# Microsoft 365 Apps for enterprise / Enterprise / E3 E4 E5
# Microsoft 365 Apps for business / Business Standard / Business Premium
# Office Small Business Premium
# Microsoft 365 Family/Personal

# Office 2024
$hashtabl_office2024 = [ordered]@{
    "ProPlus2024Retail" = ""
    "Standard2024Retail" = ""
    "HomeBusiness2024Retail" = ""
    "Home2024Retail" = ""
    "Personal2024Retail" = ""
    "Professional2024Retail" = ""
    "ProjectPro2024Retail" = ""
    "ProjectStd2024Retail" = ""
    "VisioPro2024Retail" = ""
    "VisioStd2024Retail" = ""
    "Access2024Retail" = ""
    "Excel2024Retail" = ""
    "OneNote2024Retail" = ""
    "Outlook2024Retail" = ""
    "PowerPoint2024Retail" = ""
    "Publisher2024Retail" = ""
    "Word2024Retail" = ""
    "ProPlus2024Volume" = "PerpetualVL2024"
    "Standard2024Volume" = "PerpetualVL2024"
    "ProjectPro2024Volume" = ""
    "ProjectStd2024Volume" = ""
    "VisioPro2024Volume" = ""
    "VisioStd2024Volume" = ""
    "Access2024Volume" = "PerpetualVL2024"
    "Excel2024Volume" = "PerpetualVL2024"
    "OneNote2024Volume" = "PerpetualVL2024"
    "Outlook2024Volume" = "PerpetualVL2024"
    "PowerPoint2024Volume" = "PerpetualVL2024"
    "Publisher2024Volume" = "PerpetualVL2024"
    "Word2024Volume" = "PerpetualVL2024"
}
$arra_office2024 = @()
$hashtabl_office2024.keys | ForEach-Object { $arra_office2024 += $_ }

# Office 2021
$hashtabl_office2021 = [ordered]@{
    "ProPlus2021Retail" = ""
    "Standard2021Retail" = ""
    "HomeBusiness2021Retail" = ""
    "HomeStudent2021Retail" = ""
    "Personal2021Retail" = ""
    "Professional2021Retail" = ""
    "ProjectPro2021Retail" = ""
    "ProjectStd2021Retail" = ""
    "VisioPro2021Retail" = ""
    "VisioStd2021Retail" = ""
    "Access2021Retail" = ""
    "Excel2021Retail" = ""
    "OneNote2021Retail" = ""
    "Outlook2021Retail" = ""
    "PowerPoint2021Retail" = ""
    "Publisher2021Retail" = ""
    "Word2021Retail" = ""
    "ProPlus2021Volume" = "PerpetualVL2021"
    "Standard2021Volume" = "PerpetualVL2021"
    "ProjectPro2021Volume" = ""
    "ProjectStd2021Volume" = ""
    "VisioPro2021Volume" = ""
    "VisioStd2021Volume" = ""
    "Access2021Volume" = "PerpetualVL2021"
    "Excel2021Volume" = "PerpetualVL2021"
    "OneNote2021Volume" = "PerpetualVL2021"
    "Outlook2021Volume" = "PerpetualVL2021"
    "PowerPoint2021Volume" = "PerpetualVL2021"
    "Publisher2021Volume" = "PerpetualVL2021"
    "Word2021Volume" = "PerpetualVL2021"
}
$arra_office2021 = @()
$hashtabl_office2021.keys | ForEach-Object { $arra_office2021 += $_ }

# Office 2019
$hashtabl_office2019 = [ordered]@{
    "ProPlus2019Retail" = ""
    "Standard2019Retail" = ""
    "HomeBusiness2019Retail" = ""
    "HomeStudent2019Retail" = ""
    "Personal2019Retail" = ""
    "Professional2019Retail" = ""
    "ProjectPro2019Retail" = ""
    "ProjectStd2019Retail" = ""
    "VisioPro2019Retail" = ""
    "VisioStd2019Retail" = ""
    "Access2019Retail" = ""
    "Excel2019Retail" = ""
    "OneNote2019Retail" = ""
    "Outlook2019Retail" = ""
    "PowerPoint2019Retail" = ""
    "Publisher2019Retail" = ""
    "Word2019Retail" = ""
    "ProPlus2019Volume" = "PerpetualVL2019"
    "Standard2019Volume" = "PerpetualVL2019"
    "ProjectPro2019Volume" = ""
    "ProjectStd2019Volume" = ""
    "VisioPro2019Volume" = ""
    "VisioStd2019Volume" = ""
    "Access2019Volume" = "PerpetualVL2019"
    "Excel2019Volume" = "PerpetualVL2019"
    "OneNote2019Volume" = "PerpetualVL2019"
    "Outlook2019Volume" = "PerpetualVL2019"
    "PowerPoint2019Volume" = "PerpetualVL2019"
    "Publisher2019Volume" = "PerpetualVL2019"
    "Word2019Volume" = "PerpetualVL2019"
}
$arra_office2019 = @()
$hashtabl_office2019.keys | ForEach-Object { $arra_office2019 += $_ }

# Office 2016
$hashtabl_office2016 = [ordered]@{
    "ProPlusRetail" = ""
    "StandardRetail" = ""
    "HomeBusinessRetail" = ""
    "HomeStudentRetail" = ""
    "ProfessionalRetail" = ""
    "ProjectProRetail" = ""
    "ProjectStdRetail" = ""
    "VisioProRetail" = ""
    "VisioStdRetail" = ""
    "AccessRetail" = ""
    "ExcelRetail" = ""
    "OneNoteRetail" = ""
    "OutlookRetail" = ""
    "PowerPointRetail" = ""
    "PublisherRetail" = ""
    "WordRetail" = ""
    "ProjectProXVolume" = ""
    "ProjectStdXVolume" = ""
    "VisioProXVolume" = ""
    "VisioStdXVolume" = ""
}
$arra_office2016 = @()
$hashtabl_office2016.keys | ForEach-Object { $arra_office2016 += $_ }

# Office 2013
$hashtabl_office2013 = [ordered]@{
    "O365ProPlusRetail" = ""
    "ProPlusRetail" = ""
    "StandardRetail" = ""
    "HomeBusinessRetail" = ""
    "HomeStudentRetail" = ""
    "ProfessionalRetail" = ""
    "ProjectProRetail" = ""
    "ProjectStdRetail" = ""
    "VisioProRetail" = ""
    "VisioStdRetail" = ""
    "AccessRetail" = ""
    "ExcelRetail" = ""
    "OneNoteRetail" = ""
    "OutlookRetail" = ""
    "PowerPointRetail" = ""
    "PublisherRetail" = ""
    "WordRetail" = ""
}
$arra_office2013 = @()
$hashtabl_office2013.keys | ForEach-Object { $arra_office2013 += $_ }

# For x86, change some values
if ($arch_suffix -eq "x86") {
    # Office
    # Overwrites value
    $msoffice_bit = 32
}

# Constants
$file_xml = "odtconfig.xml"

Write-Host ""

# Ask for Mode: Online Install , Offline Install, Download Only
while ($mode_onoffdown -notin 1..3) {
    [int]$mode_onoffdown = Read-Host -Prompt "Enter number - (1) Online Install , (2) Offline Install "
}

if ($mode_onoffdown -ne 1) {
    # Note
    Write-Host "Download Office installation for offline install"
    Write-Host "Download location should be the current WinSoft\Office\Data\... directory"
    Write-Host "Otherwise..."
    Write-Host "Manually download ISO and install"
    pause
}

Write-Host ""

# Ask Office Version
# List
Write-Host "List of Office versions"
foreach ($item in $list_office_versionnumber)  {
    # list
    Write-Host "Office $item"
}
Write-Host "Other versions"
Write-Host ""
while ($msoffice_ver_num -notin $list_office_versionnumber) {
    [int]$msoffice_ver_num = Read-Host -Prompt "Enter 3or4-digit number - Version: "
}
Write-Host "CONFIRMED - Version: $msoffice_ver_num"

Write-Host ""

# Initialise version and associated variables
switch ($msoffice_ver_num) {
    365 {
        # Office 365
        $dir_setup = $dir_setupexe_odt2016Plus
        $hashtabl_officeselected = $hashtabl_office365
        $arra_officeselected = $arra_office365
        break
    }
    2024 {
        # Office 2024
        $dir_setup = $dir_setupexe_odt2016Plus
        $hashtabl_officeselected = $hashtabl_office2024
        $arra_officeselected = $arra_office2024
        break
    }
    2021 {
        # Office 2021
        $dir_setup = $dir_setupexe_odt2016Plus
        $hashtabl_officeselected = $hashtabl_office2021
        $arra_officeselected = $arra_office2021
        break
    }
    2019 {
        # Office 2019
        $dir_setup = $dir_setupexe_odt2016Plus
        $hashtabl_officeselected = $hashtabl_office2019
        $arra_officeselected = $arra_office2019
        break
    }
    2016 {
        # Office 2016
        $dir_setup = $dir_setupexe_odt2016Plus
        $hashtabl_officeselected = $hashtabl_office2016
        $arra_officeselected = $arra_office2016
        break
    }
    2013 {
        # Office 2013
        $dir_setup = $dir_setupexe_odt2013
        $hashtabl_officeselected = $hashtabl_office2013
        $arra_officeselected = $arra_office2013
        break
    }
    default {
        # Default
        Write-Host "Unsupported"
        Write-Host "Press Ctrl+C to quit"
        break
    }
}

Write-Host ""

# SKU
Write-Host "List of Office SKU"
Write-Host ""
for ( $i = 0 ; $i -lt $arra_officeselected.count ; $i++ ) {
    Write-Host "$($i+1) : $($arra_officeselected[$i])"
}

Write-Host ""
# ask
Write-Host "##################################################"
Write-Host "Notes:"
Write-Host "##################################################"
Write-Host "Sequence: Main Office apps (ProPlus / Standard / Others) first, then Project / Visio"
Write-Host "Recommended: Volume versions of ProPlus / Standard / Project / Visio"
Write-Host "Not Recommended: Although Retail versions have higher build numbers, Volume versions are easier to install"
Write-Host "Note: Some SKUs are strictly Retail-only , HomeBusiness / HomeStudent / Professional , cannot be converted to VL"
Write-Host "##################################################"
Write-Host ""
# select
while ($msoffice_sku_num -notin 1..$arra_officeselected.count) {
    [int]$msoffice_sku_num = Read-Host -Prompt "Enter number - SKU: "
}
Write-Host "CONFIRMED - SKU: $msoffice_sku_num"

Write-Host ""

# Bit
Write-Host "List of Office bit (recommended 64-bit Office on 64-bit Windows)"
Write-Host "64 : "
Write-Host "32 : "
while ($msoffice_bit -notin @(64,32)) {
    [int]$msoffice_bit = Read-Host -Prompt "Enter number - Bit "
}
Write-Host "CONFIRMED - Bit: $msoffice_bit"

Write-Host ""

# Lang
Write-Host "List of Office Languages (recommended en-US)"
Write-Host "1 : MatchOS"
Write-Host "2 : MatchInstalled"
Write-Host "3 : en-US"
Write-Host "4 : zh-CN"
while ($msoffice_lang_num -notin 1..5) {
    [int]$msoffice_lang_num = Read-Host -Prompt "Enter number - Language: "
}
Write-Host "CONFIRMED - Language: $msoffice_lang_num"

Write-Host ""

# derive values
$msoffice_sku_final = $($arra_officeselected[$($msoffice_sku_num-1)])
$msoffice_channel = $hashtabl_officeselected[$msoffice_sku_final]

switch ($msoffice_lang_num) {
    1 {
        $msoffice_lang_final = "MatchOS"
        break
    }
    2 {
        $msoffice_lang_final = "MatchInstalled"
        break
    }
    3 {
        $msoffice_lang_final = "en-US"
        break
    }
    4 {
        $msoffice_lang_final = "zh-CN"
        break
    }
    5 {
        Write-Host "Opening website https://docs.microsoft.com/en-us/deployoffice/overview-deploying-languages-microsoft-365-apps#languages-culture-codes-and-companion-proofing-languages"
        Start-Process "https://docs.microsoft.com/en-us/deployoffice/overview-deploying-languages-microsoft-365-apps#languages-culture-codes-and-companion-proofing-languages"
        $msoffice_lang_final = Read-Host -Prompt "Enter language in ll-CC format: example, zh-TW for Traditional Chinese: "
        break
    }
    default {
        $msoffice_lang_final = "en-US"
        break
    }
}

Write-Host ""

# Create XML
if (Test-Path -Path $file_xml) {
    Remove-Item -Path $file_xml -Recurse -Force
}
Do {
    Add-Content -Path $file_xml -Value "<Configuration>"
    if ($mode_onoffdown -eq 1) {
        # Install
        Add-Content -Path $file_xml -Value "<Add OfficeClientEdition=`"$msoffice_bit`" Channel=`"$msoffice_channel`">"
    } else {
        # Download
        Add-Content -Path $file_xml -Value "<Add OfficeClientEdition=`"$msoffice_bit`" Channel=`"$msoffice_channel`" SourcePath=`"$PSScriptRoot`">"
    }
    Add-Content -Path $file_xml -Value "<Product ID=`"$msoffice_sku_final`">"
    Add-Content -Path $file_xml -Value "<Language ID=`"$msoffice_lang_final`" />"
    # 
    # start of Exclude section
    # 
    # Access
    if ($msoffice_exclude_Access -eq 1) {
        Add-Content -Path $file_xml -Value "<ExcludeApp ID=`"Access`" />"
    }
    # 
    # Bing
    if ($msoffice_exclude_Bing -eq 1) {
        Add-Content -Path $file_xml -Value "<ExcludeApp ID=`"Bing`" />"
    }
    # 
    # Excel
    if ($msoffice_exclude_Excel -eq 1) {
        Add-Content -Path $file_xml -Value "<ExcludeApp ID=`"Excel`" />"
    }
    # 
    # Groove
    if ($msoffice_exclude_Groove -eq 1) {
        Add-Content -Path $file_xml -Value "<ExcludeApp ID=`"Groove`" />"
    }
    # 
    # Lync
    if ($msoffice_exclude_Lync -eq 1) {
        Add-Content -Path $file_xml -Value "<ExcludeApp ID=`"Lync`" />"
    }
    # 
    # OneDrive
    if ($msoffice_exclude_OneDrive -eq 1) {
        Add-Content -Path $file_xml -Value "<ExcludeApp ID=`"OneDrive`" />"
    }
    # 
    # OneNote
    if ($msoffice_exclude_OneNote -eq 1) {
        Add-Content -Path $file_xml -Value "<ExcludeApp ID=`"OneNote`" />"
    }
    # 
    # Outlook
    if ($msoffice_exclude_Outlook -eq 1) {
        Add-Content -Path $file_xml -Value "<ExcludeApp ID=`"Outlook`" />"
    }
    # 
    # OutlookForWindows
    if ($msoffice_exclude_OutlookForWindows -eq 1) {
        Add-Content -Path $file_xml -Value "<ExcludeApp ID=`"OutlookForWindows`" />"
    }
    # 
    # PowerPoint
    if ($msoffice_exclude_PowerPoint -eq 1) {
        Add-Content -Path $file_xml -Value "<ExcludeApp ID=`"PowerPoint`" />"
    }
    # 
    # Publisher
    if ($msoffice_exclude_Publisher -eq 1) {
        Add-Content -Path $file_xml -Value "<ExcludeApp ID=`"Publisher`" />"
    }
    # 
    # Teams
    if ($msoffice_exclude_Teams -eq 1) {
        Add-Content -Path $file_xml -Value "<ExcludeApp ID=`"Teams`" />"
    }
    # 
    # Word
    if ($msoffice_exclude_Word -eq 1) {
        Add-Content -Path $file_xml -Value "<ExcludeApp ID=`"Word`" />"
    }
    # 
    # end of Exclude section
    # 
    Add-Content -Path $file_xml -Value "</Product>"
    Add-Content -Path $file_xml -Value "</Add>"
    Add-Content -Path $file_xml -Value "<Display Level=`"Full`" AcceptEULA=`"TRUE`" />"
    Add-Content -Path $file_xml -Value "</Configuration>"
} while (-Not (Test-Path -Path $file_xml))


Write-Host ""

# work
Write-Host "Working ..."
if ($mode_onoffdown -ne 3) {
    # Install
    .$dir_setup\setup.exe /configure $file_xml
} else {
    # Download
    .$dir_setup\setup.exe /download $file_xml
}

# copy shortcut
# 
# Office general
# def
$list_linkfiles = @("Access.lnk" , "Excel.lnk" , "OneDrive.lnk" , "OneNote.lnk" , "Outlook (classic).lnk" , "Outlook.lnk" , "PowerPoint.lnk" , "Project.lnk" , "Visio.lnk" , "Word.lnk")
# copy
foreach ($item in $list_linkfiles)  {
    $path_file_shortcut = "$dir_startmenuprograms_allusers\$item"
    if (Test-Path -Path $path_file_shortcut) {
        Copy-Item -Path $path_file_shortcut -Destination "$dir_desktop_allusers" -Force
    }
}
# 
# Office others
# def
$list_linkfiles = @("OneDrive for Business.lnk" , "Publisher.lnk" , "Skype for Business.lnk" , "Sticky Notes (new).lnk")
# copy
foreach ($item in $list_linkfiles)  {
    $path_file_shortcut = "$dir_startmenuprograms_allusers\$item"
    if (Test-Path -Path $path_file_shortcut) {
        Copy-Item -Path $path_file_shortcut -Destination "$dir_desktop_allusers" -Force
    }
}
# 

# Office 2016
if ($msoffice_ver_num -eq "2016") {
    # def
    $list_linkfiles = @("Access 2016.lnk" , "Excel 2016.lnk" , "OneDrive for Business.lnk" , "OneNote 2016.lnk" , "Outlook 2016.lnk" , "PowerPoint 2016.lnk" , "Project 2016.lnk" , "Publisher 2016.lnk" , "Skype for Business 2016.lnk" , "Visio 2016.lnk" , "Word 2016.lnk")
    # copy
    foreach ($item in $list_linkfiles)  {
        $path_file_shortcut = "$dir_startmenuprograms_allusers\$item"
        if (Test-Path -Path $path_file_shortcut) {
            Copy-Item -Path $path_file_shortcut -Destination "$dir_desktop_allusers" -Force
        }
    }
}
# 
# Office 2013
if ($msoffice_ver_num -eq "2013") {
    # def
    $list_linkfiles = @("Access 2013.lnk" , "Excel 2013.lnk" , "InfoPath Designer 2013.lnk" , "Lync 2013.lnk" , "OneDrive for Business 2013.lnk" , "OneNote 2013.lnk" , "Outlook 2013.lnk" , "PowerPoint 2013.lnk" , "Project 2013.lnk" , "Publisher 2013.lnk" , "Skype for Business 2015.lnk" , "Visio 2013.lnk" , "Word 2013.lnk")
    # copy
    foreach ($item in $list_linkfiles)  {
        $path_file_shortcut = "$dir_startmenuprograms_allusers\Microsoft Office 2013\$item"
        if (Test-Path -Path $path_file_shortcut) {
            Copy-Item -Path $path_file_shortcut -Destination "$dir_desktop_allusers" -Force
        }
    }
}
# 
# cleaning up
Remove-Variable path_file_shortcut

Write-Host ""

# final

# rm XML
Remove-Item -Path $file_xml -Recurse -Force

Write-Host ""

Write-Host "Terminating script-msoffice.ps1 ..."
pause


# ==================================================
# Notes
# ==================================================
