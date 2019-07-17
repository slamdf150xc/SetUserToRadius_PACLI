$VerbosePreference = 'Continue'

Set-Location -Path "PACLI"

Write-Host "Logging Off PACLI..." -NoNewLine

.\PACLI.exe LOGOFF | Out-Null
.\PACLI.exe TERM | Out-Null

Write-Host "Done!" -ForegroundColor Green