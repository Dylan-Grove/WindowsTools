$path = "c:\micros" 
$Search = "zombie"

Get-ChildItem $path -File -Recurse | %{     
     
     if(get-content $_.FullName | where $_ -like "*$Search*" 
     
}