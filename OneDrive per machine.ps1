##################################################################################################
<#
.SYNOPSIS
Migrate OneDrive for Business from per user to per machine for Intune to run with the Microsoft Intune Management Extention



.NOTES
    FileName:    OneDrive per machine.ps1
    Author:      Per Larsen
    Created:     24-03-2019
    Product:     OneDrive for Bussines
    Version:     1.0
    Blog:        https://osddeployment.dk
    
#>
###################################################################################################

$url = "https://go.microsoft.com/fwlink/?linkid=2083517"
$output = "$ENV:temp"  + '\OneDriveSetup.exe'
$O4BPath = "$ENV:localappdata" + 'Microsoft/OneDrive/OneDriveSetup.exe'

#write $O4BPath
#write $output

IF(Test-Path $output)
{

}
 ELSE {
 Invoke-WebRequest -Uri $url -OutFile $output
   }

IF(!(Test-Path $O4BPath))
  {
    & "$output" + '/allusers'
  }
 ELSE {

   }

