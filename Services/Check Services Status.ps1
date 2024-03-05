cls
$ServerList = (Get-ADComputer -Filter{Name -like "ctx*"})
$StoppedServices = 0
$TotalServices = 0

foreach($Server in $ServerList){
    if($Server.Name -eq "ctxsrv06"){ continue }
    foreach($Service in (Get-Service -Name "asi.smart.*" -ComputerName $Server.Name)){
        $TotalServices += 1
        if($Service.Status -eq "Stopped"){
            Write-host -ForegroundColor Red $Service.DisplayName " is not running..."
            Start-Service $Service -Verbose
            $StoppedServices += 1
        }
    }
}

Write-Host; Write-Host -BackgroundColor Black -ForegroundColor Yellow "Script complete. Checked a total of $TotalServices Services. Started $StoppedServices Services"