$x = 0
Get-ChildItem "F:\Eigene Dateien\Dokumente\Archiv\2019" -Filter *.msg |`
ForEach-Object{
    $currentFile = $_
    if(!($currentFile.Name -match "\d*\.\d*\.\d*\-\d*\.\d*\.\d*\-.")) {
        $outlook = New-Object -comobject outlook.application
        $msg = $outlook.CreateItemFromTemplate($currentFile.FullName)
        #$msg = $outlook.Session.OpenSharedItem($currentFile.FullName)
        $newfilename = "$($msg.Senton.ToString('yyyy.MM.dd-HH.mm.ss'))-$($msg.SenderName)-$($msg.subject)-$($x)$($_.Extension)"
        $newfilename =  $newfilename.Split([IO.Path]::GetInvalidFileNameChars()) -join '_'
        "New Name: $($newfilename)"
        Rename-Item -Path "$($currentFile.FullName)" -NewName "$($newfilename)"
    } else {
        "$($currentFile.Name)"
    }
    $x++
}
