$ClientList = Get-ADComputer -filter{cn -like "*LCPU*"}

Foreach($Client in $ClientList){
    $ClientName = $Client.Name
    $ClientPath = "\\$ClientName\c$\Windows\Temp\*"
    remove-Item -Path $ClientPath -Force -Recurse -Verbose
    }