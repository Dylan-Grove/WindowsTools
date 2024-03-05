cls

$vgnlist = 'vgn_edm','vgn_fts','vgn_led','vgn_mor','vgn_spg','vgn_sta','vgn_stp','vgn_wes'
$regvgnlist = 'vgn_mor','vgn_spg','vgn_sta','vgn_wes'

$odauth = Get-ODAuthentication -RedirectURI http://localhost/login  -clientID  -AppKey 
$at = $odauth.access_token

Function AddFile{
    sleep(.6)
    Write-host -NoNewline -ForegroundColor Cyan "Please enter the local file path: "
    $path = read-host

    $item = $path.Split('/')
    $item = $path.Split('\')
    $item = $item[-1]

    try{
        Add-ODItem -AccessToken $at -Path /Work -LocalFile $path -ErrorAction Stop
        Get-ODChildItems -AccessToken $at -Path /Work | Where-Object {$_.name -EQ $item} -ErrorAction Stop
        cls
        sleep(.6)
        write-host -ForegroundColor Green "File successfully added to OneDrive" 
        }
    catch{
        write-host -ForegroundColor Red "Failed to add $path to OneDrive. Check filename and location, then try again."
        }
}

Function DownloadFile{
    sleep(.6)
    Write-host -NoNewline -ForegroundColor Cyan "Please enter the OneDrive file path: "
    $odpath = read-host
    Write-host -NoNewline -ForegroundColor Cyan "Please enter the folder to download to: "
    $lpath = read-host
    
    $item = $path.Replace('\','/')
    $item = $path.Split('/')
    $item = $item[-1]
    foreach($pc in $vgnlist){
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
            write-host -ForegroundColor Red "Failed to download $path to $lpath from OneDrive. Check filename and location, then try again."
            }
    }
}

Write-host -NoNewline -ForegroundColor Cyan "Would you like to [a]dd or [d]ownload a file from OneDrive?: "
$choice = read-host

if($choice -eq "a" -or $choice -eq "add"){ AddFile }
elseif($choice -eq "d" -or $choice -eq "download"){ DownloadFile }
else{ 
    Write-host -ForegroundColor red "Invalid choice, please try again" 
    sleep(2)
    .\OneDriveUpload.ps1
} 


