# Ensure script runs with elevated permissions
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Output "This script requires administrative privileges. Please run as Administrator."
    Exit 1
}


# Trigger Edge update
Write-Output "Checking for Microsoft Edge updates..."
$EdgeUpdateExe = "$env:ProgramFiles(x86)\Microsoft\EdgeUpdate\MicrosoftEdgeUpdate.exe"

if (Test-Path $EdgeUpdateExe) {
    Start-Process -FilePath $EdgeUpdateExe -ArgumentList "/silent /install appguid={56EB18F8-B008-4CBD-B6D2-8C97FE7E9062}&appname=Microsoft%20Edge&needsadmin=True" -Wait
    Write-Output "Microsoft Edge update process completed."
} else {
    Write-Output "Microsoft Edge Update executable not found. Ensure Edge is installed and update services are running."
    Exit 1
}

Exit 0
