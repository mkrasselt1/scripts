# [system.enum]::getnames([System.Security.AccessControl.FileSystemRights])
$base = "C:/Firma/Scan/"
$files = Get-Childitem -Path $base -recurse
foreach ($file in $files){
    #Write-Output $file.FullName
    #Get-Acl $file.FullName | fl
    $acl = Get-Acl $file.FullName

    #Eigentümer ändern
    $object = New-Object System.Security.Principal.Ntaccount("Server\Mitarbeiter")
    #$object = New-Object System.Security.Principal.Ntaccount("Server\Administrator")
    $acl.SetOwner($object)


    #Vererbung: ja/nein, vererbtes behalten ja/nein
    #$acl.SetAccessRuleProtection($true,$false)

    #rechte Entfernen
    #$usersid = New-Object System.Security.Principal.Ntaccount ("ENTERPRISE\T.Simpson")
    #$acl.PurgeAccessRules($usersid)

    #Rechte Hinzufügen
    #$AccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule("ENTERPRISE\T.Simpson","FullControl","Allow")
    #$acl.SetAccessRule($AccessRule)

    #Rechte Entfernen
    #$AccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule("ENTERPRISE\T.Simpson","FullControl","Allow")
    #$acl.RemoveAccessRule($AccessRule)

    $acl | Set-Acl $file.FullName
  }
