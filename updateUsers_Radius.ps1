.\initPacli.ps1 Prod

$users = Get-Content .\radius.txt

ForEach($user in $users) {
	Write-Host "Changing $user to use RADIUS_AUTH..."
	.\Pacli.exe UPDATEUSER DESTUSER=$user AUTHTYPE=RADIUS_AUTH | Out-Null
}

.\termPacli.ps1