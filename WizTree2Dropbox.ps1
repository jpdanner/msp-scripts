# Upload WizTree Export to Dropbox
# Created by Jason Danner
# 24/07/2019

#Download WizTree application to the computer and delete old application & export if existing

$destination1 = "C:\Temp\WizTree64.exe"
If(Test-path $destination1) {Remove-item $destination1}

$destination2 = "C:\Temp\WizTree\wiztree_export.csv"
If(Test-path $destination2) {Remove-item $destination2}

$WebClient = New-Object System.Net.WebClient
$WebClient.DownloadFile("{YOUR LINK TO WizTree64.exe HERE}","C:\Temp\WizTree64.exe")


# This uploads to a standalone Dropbox Free account
# This is to isolate it from our Aerorock Dropbox infrastructure as much as possible.

$SourceFilePath = "C:\Temp\wiztree_export.csv"

# This uploads the csv report to the folder /Ninja Reports/WizTreet Reports" in your Dropbox account. Share the "Ninja Reports" folder with your actual Dropbox account.
$TargetFilePath = "/Ninja Reports/WizTree Reports/$env:computername.csv"

$Token = "{YOUR DROPBOX API TOKEN HERE}"


$arg = '{ "path": "' + $TargetFilePath + '", "mode": "add", "autorename": true, "mute": false }'
$authorization = "Bearer " + ($token)

$headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$headers.Add("Authorization", $authorization)
$headers.Add("Dropbox-API-Arg", $arg)
$headers.Add("Content-Type", 'application/octet-stream')
 
Invoke-RestMethod -Uri https://content.dropboxapi.com/2/files/upload -Method Post -InFile $SourceFilePath -Headers $headers

#Remove files

$program = "C:\Temp\WizTree64.exe"
$ini = "C:\Temp\WizTree3.ini"

If(Test-path $SourceFilePath) {Remove-item $SourceFilePath -force}
If(Test-path $program) {Remove-item $program -force}
If(Test-path $ini) {Remove-item $ini -force}
