$odpath = read-host
$lpath = read-host
    
$item = $path.Replace('\','/')
$item = $path.Split('/')
$item = $item[-1]

try{
    get-ODItem -AccessToken $at -Path $odpath -LocalPath $lpath -ErrorAction Stop
    $errorcheck = Get-ChildItem -Path $lpath
    if($item -notin $errorcheck){throw filenotfound}
    cls
    sleep(.6)
    write-host -ForegroundColor Green "File successfully downloaded" 
    }
catch{
    echo ""
    write-host -ForegroundColor Red "Failed to download $path to $lpath from OneDrive. Check filename and locations, then try again."
    }
pause