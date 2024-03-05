$username = ""
$password = ""
$secureStringPwd = $password | ConvertTo-SecureString -AsPlainText -Force 
$creds = New-Object System.Management.Automation.PSCredential -ArgumentList $username, $secureStringPwd


function Get-RebootBoolean
{
    Param
    (
        $ComputerName
    )
    Process
    {
        
        $os = Get-WmiObject win32_operatingsystem -ComputerName $ComputerName
        $uptime = (Get-Date) - ($os.ConvertToDateTime($os.lastbootuptime))
        $minutesUp=$uptime.TotalMinutes
   
    }
    End
    {
        if($minutesUp -le 120){
            return $true
        }else{
            return $false
        }
         
    }
}
function Get-ProcessorBoolean
{
    Param
    (
        $ComputerName
    )

    Begin
    {
    }
    Process
    {
        $value=(Get-Counter -ComputerName $ComputerName -Counter “\Processor(_Total)\% Processor Time” -SampleInterval 10).CounterSamples.CookedValue
    }
    End
    {
        if($value -ge 90){
        return $true
        }else{
        return $false
        }
    }
}
function Get-MemoryBoolean
{
    Param
    (
        $ComputerName
    )

    Process
    {
        $value=gwmi -Class win32_operatingsystem -computername $ComputerName | Select-Object @{Name = "MemoryUsage"; Expression = {“{0:N2}” -f ((($_.TotalVisibleMemorySize - $_.FreePhysicalMemory)*100)/ $_.TotalVisibleMemorySize) }}
    }
    End
    {
        if($value.MemoryUsage -ge 95){
            return $true
        }else{
            return $false
        }
        
    }
}

function Get-DiskSpaceBoolean
{
    Param
    (
        $freeBoolean=$false,
        $ComputerName
    )

    Process
    {
        $diskInfo=Get-WmiObject -ComputerName $ComputerName -class win32_logicaldisk
        foreach($disk in $diskInfo){
            if($disk.DeviceID -ne 'A:'){
                if(($disk.FreeSpace/$disk.Size)*100 -le 10){
                    $freeBoolean=$true
                }
            }

        }
    }
    End
    {
        $freeBoolean
    }
}


function Get-NotRunningServices
{
    
    Param
    (
        $ComputerName
    )

    
    Process
    {
        $notRunning=Get-wmiobject -ComputerName $ComputerName win32_service -Filter "startmode = 'auto' AND state != 'running' AND Exitcode !=0"
        $count=$notRunning.Count
    }
    End
    {
        if($count -ge 0){
            return $true
        }
        else{
            return $false
        }
    }
}

$ServerList = Get-ADComputer -filter{cn -like "*srv*"}

Foreach($Server in $ServerList){
    $Server = $Server.Name
    If(Get-ProcessorBoolean -ComputerName $Server){ $EmailBody += "$Server processor utilization has exceeded 90% usage.`n`n" }
    }

Foreach($Server in $ServerList){
    $Server = $Server.Name
    If(Get-MemoryBoolean -ComputerName $Server){ $EmailBody += "$Server memory utilization has exceeded 95% usage.`n`n" }
    }

Foreach($Server in $ServerList){
    $Server = $Server.Name
    If(Get-DiskSpaceBoolean -ComputerName $Server){ $EmailBody += "$Server disk space utilization has exceeded 90% usage.`n`n" }
    }

Foreach($Server in $ServerList){
    $Server = $Server.Name
    If(Get-NotRunningServices -ComputerName $Server){ $EmailBody += "$Server has services set to automatic startup that are not running.`n`n" }
    }

Foreach($Server in $ServerList){
    $Server = $Server.Name
    If(Get-RebootBoolean -ComputerName $Server){ $EmailBody += "$Server has experienced a reboot in last 2 hours." }
    }

Send-MailMessage -credential $creds -To  -From  -SmtpServer  -Priority High -Subject "[Sysadmin Alert] Server Preformance Report" -Body $EmailBody
