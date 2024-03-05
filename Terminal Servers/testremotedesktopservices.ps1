

$Username         = ""
$Password         = ""
$SecureStringPwd  = $password | ConvertTo-SecureString -AsPlainText -Force 
$Credentials      = New-Object System.Management.Automation.PSCredential -ArgumentList $Username, $SecureStringPwd
$DomainController = ""
Enter-PSSession $DomainController -Credential $Credentials
sleep 2

$FirstName        = "pickle"
$LastName         = "sam"
$DisplayName      = ($FirstName+" "+$LastName).ToString()
$Logon            = $FirstName[0]+$LastName
$UserPath         = "OU=Insurance,OU=Staff,DC=dil,DC=local"
$FullUserPath     = "CN=$DisplayName,$UserPath"
$HomeLocation     = "\\APPSRV05\_Home\tuser"
$ProfileLocation  = "\\APPSRV05\_Profile\tuser"
$HomeDrive        = "P:"



Try{
    $User = [ADSI] "LDAP://$FullUserPath"
    $User.psbase.Invokeset("TerminalServicesProfilePath","$ProfileLocation")
    $user.psbase.InvokeSet("TerminalServicesHomeDrive", "$HomeDrive")
    $User.psbase.invokeset("TerminalServicesHomeDirectory","$HomeLocation")
    $User.setinfo()
    }
Finally{ Exit-PSSession }



