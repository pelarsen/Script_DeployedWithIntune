
<# 
Detect_MicrosoftUpdateManagedOptIn.ps1
Exit codes:
- 0 = Compliant
- 1 = Not compliant (missing or wrong value/type)
#>

$regPath = 'HKLM:\SYSTEM\CurrentControlSet\Control\SecureBoot'
$regValueName = 'MicrosoftUpdateManagedOptIn'
$expectedDecimal = 22852  # 0x5944

try {
    # Ensure the key exists
    if (-not (Test-Path -Path $regPath)) {
        Write-Output "Registry path not found: $regPath"
        exit 1
    }

    # Read value
    $item = Get-ItemProperty -Path $regPath -ErrorAction Stop
    if ($null -eq $item.$regValueName) {
        Write-Output "Value '$regValueName' not found under $regPath"
        exit 1
    }

    # Confirm type is DWORD (REG_DWORD)
    $valInfo = Get-ItemPropertyValue -Path $regPath -Name $regValueName -ErrorAction Stop
    # In PowerShell, REG_DWORD is returned as Int32
    if ($valInfo.GetType().Name -ne 'Int32') {
        Write-Output "Value '$regValueName' is not REG_DWORD (type: $($valInfo.GetType().Name))"
        exit 1
    }

    # Confirm data matches expected (decimal)
    if ($valInfo -ne $expectedDecimal) {
        Write-Output "Value '$regValueName' is $valInfo (decimal), expected $expectedDecimal"
        exit 1
    }

    Write-Output "Compliant: $regPath\$regValueName = $expectedDecimal (REG_DWORD)"
    exit 0
}
catch {
    Write-Output "Detection error: $($_.Exception.Message)"
    exit 1
}
