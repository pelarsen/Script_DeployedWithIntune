
<# 
Remediate_MicrosoftUpdateManagedOptIn.ps1
Sets REG_DWORD MicrosoftUpdateManagedOptIn to 0x5944 (decimal 22852)
#>

$regPath = 'HKLM:\SYSTEM\CurrentControlSet\Control\SecureBoot'
$regValueName = 'MicrosoftUpdateManagedOptIn'
$desiredDecimal = 22852  # 0x5944
$logRoot = "$env:ProgramData\IntuneRemediationLogs"
$logFile = Join-Path $logRoot 'SecureBoot_ManagedOptIn.log'

# Create log folder
New-Item -ItemType Directory -Path $logRoot -Force | Out-Null

function Write-Log {
    param([string]$Message)
    $stamp = Get-Date -Format 'yyyy-MM-dd HH:mm:ss'
    Add-Content -Path $logFile -Value "$stamp | $Message"
}

try {
    Write-Log "Starting remediation"

    # Ensure the parent key exists
    if (-not (Test-Path -Path $regPath)) {
        Write-Log "Registry path not found. Creating: $regPath"
        New-Item -Path $regPath -Force | Out-Null
    }

    # Set or correct the value as REG_DWORD (decimal)
    $current = $null
    if (Get-ItemProperty -Path $regPath -Name $regValueName -ErrorAction SilentlyContinue) {
        $current = (Get-ItemPropertyValue -Path $regPath -Name $regValueName -ErrorAction SilentlyContinue)
        Write-Log "Found existing value '$regValueName' = $current (decimal)"
    } else {
        Write-Log "Value '$regValueName' not present"
    }

    if ($current -ne $desiredDecimal) {
        Write-Log "Setting '$regValueName' to $desiredDecimal (decimal, 0x5944 hex)"
        New-ItemProperty -Path $regPath -Name $regValueName -PropertyType DWord -Value $desiredDecimal -Force | Out-Null
        Write-Log "Set completed"
    } else {
        Write-Log "Value already compliant"
    }

    Write-Log "Remediation completed successfully"
}
catch {
    Write-Log "Remediation error: $($_.Exception.Message)"
    throw
}
