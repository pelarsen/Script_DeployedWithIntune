$DesktopPath = [System.Environment]::GetFolderPath([System.Environment+SpecialFolder]::Desktop)
$ShortcutPath = [System.IO.Path]::Combine($DesktopPath, 'Add_Remove_Programs.lnk')
$WScriptShell = New-Object -ComObject WScript.Shell
$Shortcut = $WScriptShell.CreateShortcut($ShortcutPath)
$Shortcut.TargetPath = 'C:\Windows\Explorer.exe'
$Shortcut.Arguments = 'ms-settings:appsfeatures'
$Shortcut.WorkingDirectory = 'C:\Windows'
$Shortcut.Save()