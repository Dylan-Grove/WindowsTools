$ErrorActionPreference = "Stop"
$Date = (get-date)
$Servers = (Get-ADComputer -Filter{cn -like "*srv*" -and cn -like "E*" -and cn -ne "EPICSRV01T" -and cn -ne "EXCHSRV02"})

While($True){
    Foreach($Server in $Servers){
        sleep .3
        Try{Test-Connection -ComputerName $Server.Name -Count 1 > $null}
        Catch{ ("[$Date] "+$Server.Name+" DISCONNECTED!") >> "C:\ConnectivetyReport.txt"}
    }
}