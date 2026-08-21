#=============================================================================================================================
#
# Script Name:     Detect_DesktopShortcut_TimeSync.ps1
# Description:     Detect if TimeSync.lnk are i nthe user profiles desktop folder
# Notes:           Remediate if shortcut to not exist
#
#=============================================================================================================================



$DesktopPath = [System.Environment]::GetFolderPath([System.Environment+SpecialFolder]::Desktop)
$ShortcutPath = [System.IO.Path]::Combine($DesktopPath, 'Add_Remove_Programs.lnk')

if (Test-Path $ShortcutPath) {
    Write-Output "Shortcut exists."
    Exit 0 # Indicates compliance
} else {
    Write-Output "Shortcut missing."
    Exit 1 # Indicates non-compliance
}

