# script-teamviewerqs.ps1
# ==================================================
# Description
# ==================================================
# Usage
# ==================================================


Write-Host "Starting script-teamviewerqs.ps1 ..."

# include
# . ".\functions.ps1"
# . ".\urls.ps1"
# . ".\values.ps1"

# var
# $var = ""

# cd
Set-Location -Path "$HOME\Downloads"

# constants - pre-code
$dir_startmenuprograms_allusers = "$env:ProgramData\Microsoft\Windows\Start Menu\Programs"
$dir_desktop_allusers = "$env:PUBLIC\Desktop"
$url_TeamViewerQS13 = "https://download.teamviewer.com/download/version_13x/TeamViewerQS.exe"
# $app_toinclude_TeamViewerQS13 = 1

##################################################

# param
# $app_num = 181
$app_shortname = "TeamViewerQS13"
# $app_toinclude = (Get-Variable -Name $("app_toinclude_" + $app_shortname)).Value

# main

# param
$url_appspecific = $url_TeamViewerQS13
$dir_installer = $app_shortname + "_" + "x86"
$path_file_shortcut = "$dir_startmenuprograms_allusers\TeamViewerQS.lnk"

# download
if (-Not (Test-Path -Path $dir_installer)) {
    # url
	$url = $url_appspecific
    # 
    # create folder
    New-Item -ItemType "directory" -Path $dir_installer -Force | Out-Null
    # 
    # cd
    Push-Location -Path $dir_installer
    # 
    # download
    curl.exe -L -O $url
    # 
    # cd
    Pop-Location
}

# copy exe
$dir_destination = "C:\"
Copy-Item -Path "$dir_installer\TeamViewerQS.exe" -Destination $dir_destination -Recurse

# remove folder
Remove-Item -Path $dir_installer -Recurse -Force | Out-Null

# create lnk file
# 
# param
$path_origfile = "C:\TeamViewerQS.exe"
$path_lnkfile = "$dir_startmenuprograms_allusers\TeamViewerQS.lnk"
# 
# create
$shortcut = (New-Object -ComObject WScript.Shell).CreateShortcut($path_lnkfile)
$shortcut.TargetPath = "$path_origfile"
$shortcut.Save()
# Make lnk file to Run as admin
$bytes = [System.IO.File]::ReadAllBytes("$path_lnkfile")
$bytes[0x15] = $bytes[0x15] -bor 0x20 #set byte 21 (0x15) bit 6 (0x20) ON
[System.IO.File]::WriteAllBytes("$path_lnkfile", $bytes)

# cp lnk
if (Test-Path -Path $path_file_shortcut) {
	Copy-Item -Path $path_file_shortcut -Destination "$dir_desktop_allusers" -Force
}

# done
Write-Host ""
# clear param
Remove-Variable path_file_shortcut

##################################################

Write-Host ""

Write-Host "Terminating script-teamviewerqs.ps1 ..."
# pause


# ==================================================
# Notes
# ==================================================
