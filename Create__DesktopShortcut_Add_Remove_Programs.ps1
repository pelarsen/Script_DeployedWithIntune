$DesktopPath = [System.Environment]::GetFolderPath([System.Environment+SpecialFolder]::Desktop)
$ShortcutPath = [System.IO.Path]::Combine($DesktopPath, 'Add_Remove_Programs.lnk')
$WScriptShell = New-Object -ComObject WScript.Shell
$Shortcut = $WScriptShell.CreateShortcut($ShortcutPath)
$Shortcut.TargetPath = 'C:\Windows\System32\Rundll32.exe'
$Shortcut.Arguments = 'shell32.dll,Control_RunDLL appwiz.cpl'
$Shortcut.WorkingDirectory = 'C:\Windows\System32'
$Shortcut.Save()