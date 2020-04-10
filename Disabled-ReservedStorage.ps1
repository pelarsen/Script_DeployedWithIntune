 $Storage = Invoke-Command {DISM /Online /Get-ReservedStorageState}  
 $Output = $Storage | Select-String "Reserved storage is enabled."  
 Write-Host $Output  
 If ($Output -like "Reserved storage is enabled."){  
      Invoke-Command {DISM /Online /Set-ReservedStorageState /State:Disabled}   
 }  