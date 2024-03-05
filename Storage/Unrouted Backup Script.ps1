$Month = (Get-Culture).DateTimeFormat.GetMonthName((get-date).Month)
$MonthNum = ((get-date).Month)
$YearNum = ((get-date).Year)

$UnroutedPath = "\\appsrv03\TAM_IMAGES$\UNROUTED\"
$UnroutedFileList = (Get-ChildItem $UnroutedPath | ?{$_.LastWriteTime -lt (Get-Date).AddDays(-2)} | ?{$_.LastWriteTime -gt (Get-Date).AddDays(-10)})
$UnroutedDestination = "\\appsrv03\Idocuments\IT\Unrouted & Photos- backup\UNROUTED $YearNum\UNROUTED $YearNum $MonthNum $Month"

If(!(Test-Path $UnroutedDestination)){ mkdir $UnroutedDestination}

foreach($File in $UnroutedFileList){
    $FilePath = $File.FullName
    $FileName = $File.Name
    Move-Item -Path "$FilePath" -Destination "$UnroutedDestination$FileName"
    }
