# Ensure script runs with elevated permissions
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Output "This script requires administrative privileges. Please run as Administrator."
    Exit 1
}

# Update Microsoft Defender
Write-Output "Checking for Microsoft Defender updates..."
$MpCmdRunPath = "$env:ProgramFiles\Windows Defender\MpCmdRun.exe"

if (Test-Path $MpCmdRunPath) {
    Start-Process -FilePath $MpCmdRunPath -ArgumentList "-SignatureUpdate" -Wait
    Write-Output "Microsoft Defender update process completed."
} else {
    Write-Output "Microsoft Defender executable not found. Ensure Defender is installed and update services are running."
}

Write-Output "Edge and Defender update processes finished."
Exit 0