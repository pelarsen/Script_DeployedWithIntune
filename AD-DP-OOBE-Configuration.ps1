#Requires -Version 5.1
<#
.SYNOPSIS
Applies the specified OOBE registry values during Autopilot device preparation.

.DESCRIPTION
Intune settings:
  Run this script using the logged on credentials: No (run as SYSTEM)
  Run script in 64-bit PowerShell host: Yes
  Enforce script signature check: according to your signing policy

Assign to the AP-DP device security group and select the script in the
Autopilot device preparation policy.

The six values and paths are preserved as supplied. Some OOBE values are
undocumented implementation settings and might not affect current Windows
builds. DisablePrivacyExperience has a documented policy location under
HKLM:\SOFTWARE\Policies\Microsoft\Windows\OOBE; this script does not add that
separate policy value.

EnableFirstLogonAnimation = 1 ENABLES the first-sign-in animation.
Set its Value to 0 below if you intend to disable the animation.

This script cannot hide pages displayed before it executes. HideEULAPage is
not a guarantee that Windows will skip license acceptance. It does not bypass
sign-in, enrollment, or Windows Hello.

Registry values persist after script assignment is removed. Output includes
previous values for troubleshooting/restoration. Failures terminate execution
and report failure to Intune; successful earlier changes are not rolled back.


#>
[CmdletBinding(SupportsShouldProcess = $true)]
param()

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

if (-not [Environment]::Is64BitProcess) {
    throw 'Run this script in 64-bit PowerShell. Enable the 64-bit host in Intune.'
}

if (-not $WhatIfPreference) {
    $identity = [Security.Principal.WindowsIdentity]::GetCurrent()
    try {
        $principal = [Security.Principal.WindowsPrincipal]::new($identity)
        if (-not $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
            throw 'Run this script as SYSTEM or an elevated administrator.'
        }
    }
    finally {
        $identity.Dispose()
    }
}

$oobePath = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\OOBE'
$systemPath = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System'

$settings = @(
    @{ Path = $oobePath; Name = 'DisablePrivacyExperience'; Value = 1 }
    @{ Path = $oobePath; Name = 'DisableVoice'; Value = 1 }
    @{ Path = $oobePath; Name = 'PrivacyConsentStatus'; Value = 1 }
    @{ Path = $oobePath; Name = 'Protectyourpc'; Value = 3 }
    @{ Path = $oobePath; Name = 'HideEULAPage'; Value = 1 }
    @{ Path = $systemPath; Name = 'EnableFirstLogonAnimation'; Value = 1 }
)

foreach ($setting in $settings) {
    $path = $setting.Path
    $name = $setting.Name
    $value = $setting.Value
    $previous = 'Absent'

    if (Test-Path -LiteralPath $path) {
        $key = Get-Item -LiteralPath $path
        try {
            if ($key.GetValueNames() -contains $name) {
                $previous = "$($key.GetValueKind($name)) / $($key.GetValue($name))"
            }
        }
        finally {
            $key.Dispose()
        }
    }

    if ($PSCmdlet.ShouldProcess("$path\$name", "Set DWORD to $value (previous: $previous)")) {
        Write-Output "$path\$name - previous: $previous"
        if (-not (Test-Path -LiteralPath $path)) {
            $null = New-Item -Path $path -Force
        }
        $null = New-ItemProperty -LiteralPath $path -Name $name -Value $value -PropertyType DWord -Force

        $key = Get-Item -LiteralPath $path
        try {
            if ($key.GetValueKind($name) -ne [Microsoft.Win32.RegistryValueKind]::DWord -or
                $key.GetValue($name) -ne $value) {
                throw "Registry verification failed for $path\$name."
            }
        }
        finally {
            $key.Dispose()
        }
        Write-Output "$path\$name - verified DWORD $value"
    }
}

Write-Output 'Registry processing finished. No restart requested. OOBE page suppression is not verified by this script.'
