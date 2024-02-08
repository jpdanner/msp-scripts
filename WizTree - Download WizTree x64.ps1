#Download WizTree application to the computer and delete old application & export if existing

$destination1 = "C:\Temp\WizTree64.exe"
If(Test-path $destination1) {Remove-item $destination1}

$destination2 = "C:\Temp\WizTree\wiztree_export.csv"
If(Test-path $destination2) {Remove-item $destination2}

$WebClient = New-Object System.Net.WebClient
$WebClient.DownloadFile("{YOUR LINK TO WizTree64.exe HERE}","C:\Temp\WizTree64.exe")
