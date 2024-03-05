powershell.exe mkdir \\edm-dc-wsus\Downloads\EventLogs\$env:computername
powershell.exe xcopy /y 'C:\Windows\System32\winevt\Logs\Microsoft-Dynamics-Commerce-ModernPos%%4Operational.evtx' '\\edm-dc-wsus\Downloads\EventLogs\%COMPUTERNAME%\Microsoft-Dynamics-Commerce-ModernPos%4Operational.evtx*'
powershell.exe xcopy /y 'C:\Windows\System32\winevt\Logs\Microsoft-Dynamics-Commerce-ModernPos%%4OAdmin.evtx' '\\edm-dc-wsus\Downloads\EventLogs\%COMPUTERNAME%\Microsoft-Dynamics-Commerce-ModernPos%4Admin.evtx*'

