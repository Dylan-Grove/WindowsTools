$location=Read-host "Specify the folder location of the files"
$days=Read-host "Specify the number of days between today and the cutoff date of files you want affected" 

Get-ChildItem $location | ?{$_.LastWriteTime -lt (Get-Date).AddDays($days)} |
ForEach-Object { 
echo $_.FullName
takeown /f $_.FullName /R /d y
icacls $_.FullName /grant administrators:F
}
