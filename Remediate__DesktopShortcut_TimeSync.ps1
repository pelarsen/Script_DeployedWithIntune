#=============================================================================================================================
#
# Script Name:     Remediate__DesktopShortcut_TimeSync.ps1
# Description:     This script creates a desktop shortcut for Timesync
# Notes:           No variable substitution needed
#
#=============================================================================================================================



$DesktopPath = [System.Environment]::GetFolderPath([System.Environment+SpecialFolder]::Desktop)
$ShortcutPath = [System.IO.Path]::Combine($DesktopPath, 'SyncTime.lnk')
$WScriptShell = New-Object -ComObject WScript.Shell
$Shortcut = $WScriptShell.CreateShortcut($ShortcutPath)
$Shortcut.TargetPath = 'C:\Windows\System32\SystemSettingsAdminFlows.exe'
$Shortcut.Arguments = 'forcetimesync 1'
$Shortcut.WorkingDirectory = 'C:\Windows\System32'
$Shortcut.Save()

Write-Output "Shortcut created successfully."
Exit 0

