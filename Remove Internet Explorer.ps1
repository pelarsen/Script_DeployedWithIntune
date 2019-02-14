##################################################################################################
<#
.SYNOPSIS
A script to remove Internet Explorer


.NOTES
    FileName:    Remove Internet Explorer.ps1
    Author:      Per Larsen
    Created:     14-02-2019
    Product:     Internet Explorer
    Version:     1.0
    
#>
###################################################################################################

#Powershell Script To remove Interner Explorer
#Check If remove Interner Explorer Are Already Installed
$check = Get-WindowsOptionalFeature -Online | Where-Object {$_.FeatureName -eq "Internet-Explorer-Optional-amd64"}
If ($check.State -ne "Disabled") 
{
        #Remove Internet Explorer
        Disable-WindowsOptionalFeature -FeatureName Internet-Explorer-Optional-amd64 -Online -NoRestart | Out-Null
}


