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
    Version:     1.0
    
#>
###################################################################################################

$TenantID = "TenantID"


$registryPath = "HKLM:\SOFTWARE\Policies\Microsoft\OneDrive"
$Name = "SilentAccountConfig"
$value = "1"
IF(!(Test-Path $registryPath))
  {
    New-Item -Path $registryPath -Force | Out-Null
    New-ItemProperty -Path $registryPath -Name $name -Value $value `
    -PropertyType DWORD -Force | Out-Null}
 ELSE {
    New-ItemProperty -Path $registryPath -Name $name -Value $value `
    -PropertyType DWORD -Force | Out-Null}
$registryPath = "HKLM:\SOFTWARE\Policies\Microsoft\OneDrive"
$Name = "FilesOnDemandEnabled"
$value = "1"
IF(!(Test-Path $registryPath))
  {
    New-Item -Path $registryPath -Force | Out-Null
    New-ItemProperty -Path $registryPath -Name $name -Value $value `
    -PropertyType DWORD -Force | Out-Null}
 ELSE {
    New-ItemProperty -Path $registryPath -Name $name -Value $value `
    -PropertyType DWORD -Force | Out-Null}

    $registryPath = "HKLM:\SOFTWARE\Policies\Microsoft\OneDrive"
$Name = "KFMBlockOptIn"
$value = "1"
IF(!(Test-Path $registryPath))
  {
    New-Item -Path $registryPath -Force | Out-Null
    New-ItemProperty -Path $registryPath -Name $name -Value $value `
    -PropertyType DWORD -Force | Out-Null}
 ELSE {
    New-ItemProperty -Path $registryPath -Name $name -Value $value `
    -PropertyType DWORD -Force | Out-Null}
$registryPath = "HKLM:\SOFTWARE\Policies\Microsoft\OneDrive"
$Name = "KFMSilentOptIn"
IF(!(Test-Path $registryPath))
  {
    New-Item -Path $registryPath -Force | Out-Null
    New-ItemProperty -Path $registryPath -Name $name -Value $TenantID `
    -PropertyType String -Force | Out-Null}
 ELSE {
    New-ItemProperty -Path $registryPath -Name $name -Value $TenantID `
    -PropertyType String -Force | Out-Null}
$registryPath = "HKLM:\SOFTWARE\Policies\Microsoft\OneDrive"
$Name = "KFMSilentOptInWithNotification"
$value = "0"
IF(!(Test-Path $registryPath))
  {
    New-Item -Path $registryPath -Force | Out-Null
    New-ItemProperty -Path $registryPath -Name $name -Value $value `
    -PropertyType DWORD -Force | Out-Null}
 ELSE {
    New-ItemProperty -Path $registryPath -Name $name -Value $value `
    -PropertyType DWORD -Force | Out-Null}
$registryPath = "HKLM:\SOFTWARE\Policies\Microsoft\OneDrive"
$Name = "KFMBlockOptOut"
$value = "1"
IF(!(Test-Path $registryPath))
  {
    New-Item -Path $registryPath -Force | Out-Null
    New-ItemProperty -Path $registryPath -Name $name -Value $value `
    -PropertyType DWORD -Force | Out-Null}
 ELSE {
    New-ItemProperty -Path $registryPath -Name $name -Value $value `
    -PropertyType DWORD -Force | Out-Null}