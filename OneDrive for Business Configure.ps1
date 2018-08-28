##################################################################################################
<#
.SYNOPSIS
Policy Definition template file for Intune to run with the Microsoft Intune Management Extention
This policy setup OneDrive For Business with AutoConfigure and KFM 


.NOTES
    FileName:    OneDrive for Business Configure.ps1
    Author:      Per Larsen
    Created:     11-07-2018
    Product:     OneDrive for Business
    Version:     1.1
    
#>
###################################################################################################

$TenantID = "TenantID"

$OD4BSettings = @{
    SilentAccountConfig = @{
        registryPath  = "HKLM:\SOFTWARE\Policies\Microsoft\OneDrive"
        Name = 'SilentAccountConfig'
        value = "1"
        PropertyType = "DWORD"
    }
    FilesOnDemandEnabled = @{
        registryPath  = "HKLM:\SOFTWARE\Policies\Microsoft\OneDrive"
        Name = 'FilesOnDemandEnabled'
        value = "1"
        PropertyType = "DWORD"
    }
    KFMBlockOptIn = @{
        registryPath  = "HKLM:\SOFTWARE\Policies\Microsoft\OneDrive"
        Name = 'KFMBlockOptIn'
        value = "1"
        PropertyType = "DWORD"
    }
    KFMSilentOptIn = @{
        registryPath  = "HKLM:\SOFTWARE\Policies\Microsoft\OneDrive"
        Name = 'KFMSilentOptIn'
        value = $TenantID
        PropertyType = "String"
    }
    KFMSilentOptInWithNotification = @{
        registryPath  = "HKLM:\SOFTWARE\Policies\Microsoft\OneDrive"
        Name = 'KFMSilentOptInWithNotification'
        value = "0"
        PropertyType = "DWORD"
    }
    KFMBlockOptOut = @{
        registryPath  = "HKLM:\SOFTWARE\Policies\Microsoft\OneDrive"
        Name = 'KFMBlockOptOut'
        value = "1"
        PropertyType = "DWORD"
    }
}


function Update-RegistryValue {
    param (
        [Parameter(Mandatory=$true)]
        $registryPath,
        [Parameter(Mandatory=$true)]
        $Name,
        [Parameter(Mandatory=$true)]
        $value,
        [Parameter(Mandatory=$true)]
        $PropertyType
    )

    IF(!(Test-Path $registryPath)) {
        New-Item -Path $registryPath -Force | Out-Null
        New-ItemProperty -Path $registryPath -Name $Name -Value $value `
        -PropertyType $PropertyType -Force | Out-Null}
    ELSE {
        New-ItemProperty -Path $registryPath -Name $Name -Value $value `
        -PropertyType $PropertyType -Force | Out-Null
    }
    
    
}

# Loop the hashtable...
ForEach ($Setting in $OD4BSettings.Keys)
{
   Update-RegistryValue -registryPath $OD4BSettings[$Setting].registryPath `
    -Name $OD4BSettings[$Setting].Name `
    -value $OD4BSettings[$Setting].value `
    -PropertyType $OD4BSettings[$Setting].PropertyType

}
