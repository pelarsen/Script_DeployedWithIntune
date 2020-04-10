 $Storage = Invoke-Command {DISM /Online /Get-ReservedStorageState}  
 $Output = $Storage | Select-String "Reserved storage is disabled."  
 Write-Host $Output  
 If ($Output -like "Reserved storage is disabled."){  
      Invoke-Command {DISM /Online /Set-ReservedStorageState /State:Enabled}   
 }  