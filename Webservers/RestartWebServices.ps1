cls; echo "Please enter Administrator credentials."
invoke-command -computername WEBSRV05 -scriptblock{
    cls; echo "Restarting website services on WEBSRV05..."; echo ""; 
    try{ 
        restart-service -name w3svc,ApphostSvc,WAS -force -verbose
        echo ""; echo "Services successfully restarted..."; 
        get-service -name w3svc,ApphostSvc,WAS | ft -Property Status,Name,DisplayName
        }
    catch{ write-output "An error occured when attempting to restart the website services..."; write-output $PSItem
    pause}
    }
echo ""; echo ""; pause