# Policy Definition template file for Intune
# Product: Acting Admin
# Version: 1.0.0
# Revision: 1.0.0

New-Item -Path "HKLM:\Software\Policies\Atea Global Services" -Name "Acting Admin" –Force 
$registryPath = "HKLM:\Software\Policies\Atea Global Services\Acting Admin"

# "SecondsAsAdministratorPrompt" minValue="1" maxValue="3600"
# Determines how many seconds the user should be administrator. 
$Name = "SecondsAsAdministrator"
$value = "120"
IF(!(Test-Path $registryPath))
  {
    New-Item -Path $registryPath -Force | Out-Null
    New-ItemProperty -Path $registryPath -Name $name -Value $value `
    -PropertyType DWORD -Force | Out-Null}
 ELSE {
    New-ItemProperty -Path $registryPath -Name $name -Value $value `
    -PropertyType DWORD -Force | Out-Null}

# "IsExitMenuItemVisible" Enable="1" disable="0"
# Is the menu item “exit” available for the tray icon? 
$Name = "IsExitMenuItemVisible"
$value = "1"
IF(!(Test-Path $registryPath))
  {
    New-Item -Path $registryPath -Force | Out-Null
    New-ItemProperty -Path $registryPath -Name $name -Value $value `
    -PropertyType DWORD -Force | Out-Null}
 ELSE {
    New-ItemProperty -Path $registryPath -Name $name -Value $value `
    -PropertyType DWORD -Force | Out-Null}

# "IsTimeExtendable" Enable="1" disable="0"
# Determines whether the user can extend the time for administrative rights or not. 
$Name = "IsTimeExtendable"
$value = "1"
IF(!(Test-Path $registryPath))
  {
    New-Item -Path $registryPath -Force | Out-Null
    New-ItemProperty -Path $registryPath -Name $name -Value $value `
    -PropertyType DWORD -Force | Out-Null}
 ELSE {
    New-ItemProperty -Path $registryPath -Name $name -Value $value `
    -PropertyType DWORD -Force | Out-Null}

# "IsApplicationEnabled" Enable="1" disable="0"
# If set to false, the application cannot be used to elevate.
$Name = "IsApplicationEnabled"
$value = "1"
IF(!(Test-Path $registryPath))
  {
    New-Item -Path $registryPath -Force | Out-Null
    New-ItemProperty -Path $registryPath -Name $name -Value $value `
    -PropertyType DWORD -Force | Out-Null}
 ELSE {
    New-ItemProperty -Path $registryPath -Name $name -Value $value `
    -PropertyType DWORD -Force | Out-Null}

# "IsApplicationInsightsDisabled" Enable="1" disable="0"
# If set to true, the application will not send usage and crash information to manufacturer. 
$Name = "IsApplicationInsightsDisabled"
$value = "1"
IF(!(Test-Path $registryPath))
  {
    New-Item -Path $registryPath -Force | Out-Null
    New-ItemProperty -Path $registryPath -Name $name -Value $value `
    -PropertyType DWORD -Force | Out-Null}
 ELSE {
    New-ItemProperty -Path $registryPath -Name $name -Value $value `
    -PropertyType DWORD -Force | Out-Null}

# "VerbosityLevel" Normal="Normal" Debug="Debug"
# If set to Debug, more verbose logging will be written in the Event Log. 
$Name = "VerbosityLevel"
$value = "Normal"
IF(!(Test-Path $registryPath))
  {
    New-Item -Path $registryPath -Force | Out-Null
    New-ItemProperty -Path $registryPath -Name $name -Value $value `
    -PropertyType String -Force | Out-Null}
 ELSE {
    New-ItemProperty -Path $registryPath -Name $name -Value $value `
    -PropertyType String -Force | Out-Null}   

# "GroupnameOrSid" 
# Name or SID for the group used for elevation. Default value is the wellknown SID for BUILTIN\Administrators 
# S-1-5-32-547 is the wellknown SID for BUILTIN\PowerUsers
$Name = "GroupnameOrSid"
$value = "S-1-5-32-544"
IF(!(Test-Path $registryPath))
  {
    New-Item -Path $registryPath -Force | Out-Null
    New-ItemProperty -Path $registryPath -Name $name -Value $value `
    -PropertyType String -Force | Out-Null}
 ELSE {
    New-ItemProperty -Path $registryPath -Name $name -Value $value `
    -PropertyType String -Force | Out-Null}   

    