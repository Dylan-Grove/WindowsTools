invoke-command -computername WEBSRV05.dil.local -scriptblock{
    try{ 
        restart-service -name w3svc,ApphostSvc,WAS -force -verbose
        get-service -name w3svc,ApphostSvc,WAS | ft -Property Status,Name,DisplayName
        }
    catch{ write-output "An error occured when attempting to restart the website services..."; write-output $PSItem}
    }
