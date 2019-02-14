$registryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Internet Explorer\Main\EnterpriseMode"

#Send all sites not included in the Enterprise Mode Site List to Microsoft Edge.
$Name = "RestrictIE"
$value = "1"
IF((Test-Path -LiteralPath $registryPath) -ne $true) 
{  New-Item $registryPath -force -ea SilentlyContinue };
New-ItemProperty -LiteralPath $registryPath -Name $Name -Value $value -PropertyType DWord -Force -ea SilentlyContinue;



  