foreach($srv in 1..5){
    $path = "\\CTXSRV0$srv\C$\Users"
    $limit=(get-date).AddDays(-105)
    $exclude="Public","Default User","Administrator","Default","All Users","lshaw","akilleen","curlacher","stat123","nicole.berg"
    echo ""
    echo "CTXSRV$srv Old User Accounts"
    echo "Name          LastWriteTime"
    echo "----          -------------  "
    $names = Get-ChildItem -Path $path -Force | Where-Object { $_.PSIsContainer -and $_.LastWriteTime -lt $limit -and $exclude -notcontains $_.Name} | sort LastWriteTime |  select Name,LastWriteTime
}

$limit=(get-date).AddDays(-105)
$exclude="Public","Default User","Administrator","Default","All Users","lshaw","akilleen","curlacher","stat123","nicole.berg"

$names = Get-ChildItem -Path \\SRV01\C$\Users -Force | Where-Object { $_.PSIsContainer -and $_.LastWriteTime -lt $limit -and $exclude -notcontains $_.Name} | sort LastWriteTime |  select Name,LastWriteTime
$names += Get-ChildItem -Path \\SRV02\C$\Users -Force | Where-Object { $_.PSIsContainer -and $_.LastWriteTime -lt $limit -and $exclude -notcontains $_.Name} | sort LastWriteTime |  select Name,LastWriteTime
$names += Get-ChildItem -Path \\SRV03\C$\Users -Force | Where-Object { $_.PSIsContainer -and $_.LastWriteTime -lt $limit -and $exclude -notcontains $_.Name} | sort LastWriteTime |  select Name,LastWriteTime
$names += Get-ChildItem -Path \\SRV04\C$\Users -Force | Where-Object { $_.PSIsContainer -and $_.LastWriteTime -lt $limit -and $exclude -notcontains $_.Name} | sort LastWriteTime |  select Name,LastWriteTime
$names += Get-ChildItem -Path \\SRV05\C$\Users -Force | Where-Object { $_.PSIsContainer -and $_.LastWriteTime -lt $limit -and $exclude -notcontains $_.Name} | sort LastWriteTime |  select Name,LastWriteTime


$names.name | select -unique | sort Name

