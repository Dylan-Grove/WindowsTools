$username = ""
$password = ""
$secureStringPwd = $password | ConvertTo-SecureString -AsPlainText -Force 
$Credentials = New-Object System.Management.Automation.PSCredential -ArgumentList $username, $secureStringPwd

$Server = ""
$LogFile = "C:\SageAlertsServiceLog.txt"
$Date = (Get-Date)

$EmailTo = ""
$EmailFrom = ""
$EmailServer = ""


foreach($Service in (Get-Service -Name "sage*" -ComputerName $Server)){
        if($Service.Status -eq "Stopped"){
            $AlertMessage = "[$Date] Stopped Sage Service Detected! ("+$Service.DisplayName+")."
            ($AlertMessage,"`n[$Date] Sending Email to $EmailTo`n`n") >> $LogFile
            $EmailBody = $AlertMessage.ToString()
            Send-MailMessage -credential $Credentials -To $EmailTo -From $EmailFrom -SmtpServer $EmailServer -Priority High -Subject "[Alert] Stopped Service Detected!" -Body $AlertMessage

        }
}