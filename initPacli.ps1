param(
	[Parameter(Mandatory=$true)][string]$Environment,
	[string]$Safe
	)

$VerbosePreference = 'Continue'

Set-Location -Path "PACLI"

$loginUser = "PACLI"
$vault = "vault"
$ip = ""

Switch ($Environment.ToLower()) {
		dev {
			$ip = "xxx.xxx.xxx.xxx"
		}
		qa {
			$ip = "xxx.xxx.xxx.xxx"
		}
		prod {
			$ip = "xxx.xxx.xxx.xxx"
		}
	}
	
	If ($ip) {
		Write-Host "Logging you into $Environment as $loginUser..." -NoNewLine
		
		.\PACLI.exe INIT | Out-Null
		.\PACLI.exe DEFINE VAULT=`"$vault`" ADDRESS=`"$ip`" | Out-Null
		
		If (-not ([string]::IsNullOrEmpty($Safe))) {
			.\PACLI.exe DEFAULT USER=`"$loginUser`" VAULT=`"$vault`" SAFE=`"$Safe`" FOLDER=`"root`" | Out-Null
		} Else {
			.\PACLI.exe DEFAULT USER=`"$loginUser`" VAULT=`"$vault`" FOLDER=`"root`" | Out-Null
		}
		
		.\PACLI.exe LOGON LOGONFILE=`"pacli.cred`" | Out-Null
		
		Write-Host "Done!" -ForegroundColor Green
		Write-Host "The following values are set..."
		Write-Host "USER=$loginUser"
		Write-Host "VAULT=$vault"
		Write-Host "FOLDER=ROOT"
		If (-not ([string]::IsNullOrEmpty($Safe))) {
			Write-Host "SAFE=$Safe"
		}
	} Else {
		Write-Host "IP is blank: $ip" -ForegroundColor Red
	}
