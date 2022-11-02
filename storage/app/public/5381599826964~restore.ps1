CLS

$choice = Read-Host "Are you (i)mporting or (e)xporting, Choose i or e"

if ($choice -eq "e")
{
    

    new-item "$env:OneDrive\Zip_Transfers" -ItemType Directory -Force | out-null
    New-Item "$env:OneDrive\Zip_Transfers\Archives" -ItemType Directory -Force | out-null
    New-Item "$env:OneDrive\Zip_Transfers\Chrome" -ItemType Directory -Force | out-null
    New-Item "$env:OneDrive\Zip_Transfers\IE" -ItemType Directory -Force | out-null
    New-Item "$env:OneDrive\Zip_Transfers\Edge" -ItemType Directory -Force | out-null

    Write-Host "Closing IE...." -ForegroundColor yellow
    get-process iexplore* | Stop-Process


    Write-Host "Closing Edge...." -ForegroundColor yellow
    get-process *Edge* | Stop-Process


    
    #### Compress and copy .pst files #########

    

    $answer = read-host "Do you wish to scan for mail archives? y or n"

    if ($answer -eq "y")
    {
        Write-Host "Closing Outlook...." -ForegroundColor yellow
        get-process outlook* | Stop-Process
        Start-Sleep -Seconds 3
        Write-Host "Looking for .pst files.This may take a while...." -ForegroundColor yellow
        $path = "$env:LOCALAPPDATA\Microsoft\Outlook"
        Get-ChildItem $env:HOMEPATH -Recurse -Force -ErrorAction Continue | where {$_.Extension -eq ".pst"} | tee-object -Variable 'pst' | compress-Archive -DestinationPath "$env:OneDrive\Zip_Transfers\Archives\mailArchives" -force
        foreach($file in $pst)
        {
            write-host -ForegroundColor Yellow "Sucessfully compressed and copied"  $file.name
        }
        Write-Host $pst.count " .pst files sucessfully compressed and copied...." -ForegroundColor yellow
        Start-Sleep -Seconds 2
        write-host "Restarting Outlook" -ForegroundColor yellow
        Start-Process Outlook.exe

    }

    ####### copy Chrome #######

    Write-Host "Closing Chrome...." -ForegroundColor yellow
    get-process chrome* | Stop-Process
    start-Sleep -Seconds 5


    Copy-Item  "$env:LOCALAPPDATA\Google\Chrome\User Data\Default\Bookmarks" -Destination "$env:OneDrive\Zip_Transfers\Chrome" -Force
    
    Copy-Item  "$env:LOCALAPPDATA\Google\Chrome\User Data\Default\Favicons" -Destination "$env:OneDrive\Zip_Transfers\Chrome" -Force
    
    Copy-Item  "$env:LOCALAPPDATA\Google\Chrome\User Data\Default\Favicons-journal" -Destination "$env:OneDrive\Zip_Transfers\Chrome" -Force
    Copy-Item  "$env:LOCALAPPDATA\Google\Chrome\User Data\Default\Login Data" -Destination "$env:OneDrive\Zip_Transfers\Chrome" -Force
    Copy-Item  "$env:LOCALAPPDATA\Google\Chrome\User Data\Default\Login Data-Journal" -Destination "$env:OneDrive\Zip_Transfers\Chrome" -Force

    Write-Host "Chrome sucessfully compressed and copied...." -ForegroundColor yellow

    Start-Sleep -Seconds 3
    Write-Host "Restarting Chrome" -ForegroundColor yellow
    Start-Process Chrome.exe

    ######### Export IE Bookmarks #########

    
    Write-Host "Exporting IE bookmarks...." -ForegroundColor yellow
    $path = "$HOME\Favorites\*"
    Copy-Item $path -Destination $env:OneDrive\Zip_Transfers\IE -ErrorAction Continue -Recurse -Exclude *.ini -Force
    Write-Host "Sucessfully exported IE bookmarks...." -ForegroundColor yellow
    
    ############## Copying Edge Favorites #############

    Write-Host "Exporting Edge Favorites...." -ForegroundColor yellow
    $edgeFavPath = "$env:LOCALAPPDATA\Packages\Microsoft.MicrosoftEdge_8wekyb3d8bbwe\AC\MicrosoftEdge\User\Default\DataStore/*"
    Copy-Item -Path $EdgeFavPath -Recurse -Destination "$env:OneDrive\Zip_Transfers\Edge"  -ErrorAction Continue -Force
  


    ################ Completed #############

    write-host -ForegroundColor Green "Completed"

} 
    elseif($choice -eq "i")
{
   

    write-host -ForegroundColor yellow "Beginning import"
    Write-Host "Closing IE...." -ForegroundColor yellow
    get-process iexplore* | Stop-Process

    Write-Host "Closing Chrome...." -ForegroundColor yellow
    get-process chrome* | Stop-Process
    
    Write-Host "Closing Outlook...." -ForegroundColor yellow
    get-process outlook* | Stop-Process

    start-sleep -Seconds 3

    if(test-path -Path "$env:OneDrive\Zip_Transfers\Archives\mailArchives.zip")
    {
        write-host -ForegroundColor yellow "Expanding and copying mail Archives to AppData\Local\Microsoft\Outlook...."
        Expand-Archive -path "$env:OneDrive\Zip_Transfers\Archives\mailArchives.zip" -Destination "$env:LOCALAPPDATA\Microsoft\Outlook" -Force
    }

    if(test-path -Path "$env:OneDrive\Zip_Transfers\Chrome\Bookmarks")
    {
        write-host -ForegroundColor yellow "Expanding and copying Chrome...."
        Copy-Item "$env:OneDrive\Zip_Transfers\Chrome\Bookmarks" -Destination "$env:LOCALAPPDATA\Google\Chrome\User Data\Default\" -Force
        Copy-Item "$env:OneDrive\Zip_Transfers\Chrome\Favicons" -Destination "$env:LOCALAPPDATA\Google\Chrome\User Data\Default\" -Force
        Copy-Item "$env:OneDrive\Zip_Transfers\Chrome\Favicons-Journal" -Destination "$env:LOCALAPPDATA\Google\Chrome\User Data\Default\" -Force
        Copy-Item "$env:OneDrive\Zip_Transfers\Chrome\Login Data" -Destination "$env:LOCALAPPDATA\Google\Chrome\User Data\Default\" -Force
        Copy-Item "$env:OneDrive\Zip_Transfers\Chrome\Login Data-Journal" -Destination "$env:LOCALAPPDATA\Google\Chrome\User Data\Default\" -Force
    }
   
    write-host -ForegroundColor yellow "Copying IE...."
    Copy-Item $env:OneDrive\Zip_Transfers\IE\*  -Recurse -Destination "$env:HOMEPATH\Favorites\" -ErrorAction SilentlyContinue -Force

    Write-Host "Closing Edge...." -ForegroundColor yellow
    get-process *Edge* | Stop-Process
    Start-Sleep -Seconds 3
    Write-Host "Importing Edge...." -ForegroundColor yellow
    Copy-Item -Path "$env:OneDrive\Zip_Transfers\Edge\*" -ErrorAction Continue -Destination "$env:LOCALAPPDATA\Packages\Microsoft.MicrosoftEdge_8wekyb3d8bbwe\AC\MicrosoftEdge\User\Default\DataStore" -recurse -Force 
    

    ########## Completed ###########

    write-host -ForegroundColor Green "Completed"}


############# END ##################