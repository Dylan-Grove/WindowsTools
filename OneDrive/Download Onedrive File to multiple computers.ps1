cls
sleep(.6)

# Workstation Variables
$RemoteWorkstations = '192.168.0.1',""

# OneDrive Authentication Variables
$ODAuthentication = Get-ODAuthentication -RedirectURI http://localhost/login  -clientID -AppKey
$ODAccessToken = $ODAuthentication.access_token

# Workstation Credentials
$username = ""
$password = ""
$secureStringPwd = $password | ConvertTo-SecureString -AsPlainText -Force 
$cred = New-Object System.Management.Automation.PSCredential -ArgumentList $username, $secureStringPwd

# Path variables
$ODFilePath = "files\file1.txt"
$LocalFilePath = "C:\filepath"
$ODFile = $LocalFilePath.Split('\')
$ODFile = $LocalFilePath.Split('/')
$ODFile = $ODFile[-1]
 
# Iterate through remote workstations and download files 
Foreach($Workstation in $RemoteWorkstations){
        
        Invoke-Command -ComputerName $Workstation -Credential $cred -ErrorAction Stop -ArgumentList $ODFilePath,$LocalFilePath,$ODAuthentication,$ODAccessToken -ScriptBlock{
            $ODFilePath = $args[0]
            $LocalFilePath = $args[1]
            $ODAuthentication = $args[2]
            $ODAccessToken = $args[3]
              
            Write-host -ForegroundColor Gray "Beginning download to $env:computername" 
            Import-Module OneDrive

            # Test for destination folder, create it if it isn't there
                If(!(Test-Path -Path "$LocalFilePath"] )){
                    New-Item -ItemType directory -Path "$LocalFilePath" *>$null
                    Write-host -ForegroundColor Gray "Created missing destination folder" 
                    }

            # Download file from OneDrive
                Get-ODItem -AccessToken $ODAccessToken -Path "$ODFilePath" -LocalPath "$LocalFilePath" *>$null
            
            # Test if file is in location            
                If(!(Test-Path -Path "$LocalFilePath" )){
                    Write-host -ForegroundColor Red "Failed to download file to $env:computername from OneDrive. Check filename and locations, then try again."
                    }
            
            # If no errors, inform user file was successful   
                Else{
                    Write-host -ForegroundColor Green "File successfully downloaded to $env:computername`n`n`n" 
                    }
                }
            }