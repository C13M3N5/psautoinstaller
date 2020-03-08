<# 
.SYNOPSIS 
	Installiert Programme über Chocolatey
.DESCRIPTION 
	Checkt ob Chocolatey installiert ist dann wird es installiert.
	Dann werden die ausgewählten Programme in der CSV-Datei installiert oder deinstalliert
.EXAMPLE 
	install.ps1 
#>

# Get the programm.csv
$csvdatapath = $PSScriptRoot + "\programs.csv"



function Intall-Programm($program){
	$checkprogram = $chocolistinstall | Where-object { $_.ToLower().StartsWith($program.ToLower()) }
	if($checkprogram -eq $null){
		choco install $program -y
		# Fehlercode von Choco auswerten
		if($LASTEXITCODE){
			return 1
		}else{
			return 0
		}
	}
	return 2

}

function Unintall-Programm($program){
	$checkprogram = $chocolistinstall | Where-object { $_.ToLower().StartsWith($program.ToLower()) }
	if($checkprogram -ne $null){
		choco uninstall $program -y --remove-dependencies
		# Fehlercode von Choco auswerten
		if($LASTEXITCODE){
			return 1
		}else{
			return 0
		}
	}
	return 2
}



if(!(Test-Path $csvdatapath)){
	"CSV Datei nicht gefunden! Bitte im Verzeichnis des Skripts ablegen."
	exit
}

$testchoco = powershell choco -v
if(-not($testchoco)){
    Write-Output "Seems Chocolatey is not installed, installing now"
    Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
}
else{
    Write-Output "Chocolatey Version $testchoco is already installed"
}

# CSV-Datei auslesen
$csvdata = Import-CSV $csvdatapath -delimiter ";"

# Alle installierten Pakete auslesen
$chocolistinstall = choco list -lo

#Array für den späteren CSV Export anlegen
$outarray = @()

foreach($row in $csvdata){
	$install = $row.install
	$programm = $row.programm
	$description = $row.description
	$timestamp = Get-Date -Format "dd.MM.yyyy-HH:mm"
	if($install -eq 1){
		$installreturn = Intall-Programm $programm 
		if($installreturn -eq 0){
			$status = $timestamp + " - Erfolgreich installiert"
		}elseif($installreturn -eq 1){
			$status = $timestamp + " - Fehler bei der Installation"
		}elseif($installreturn -eq 2){
			$status = $timestamp + " - schon installiert"
		}
	
	}elseif($install -eq 0){
		$installreturn = Unintall-Programm $programm 
		if($installreturn -eq 0){
			$status = $timestamp + " - Erfolgreich deinstalliert"
		}elseif($installreturn -eq 1){
			$status = $timestamp + " - Fehler bei der Deinstallation"
		}elseif($installreturn -eq 2){
			$status = $timestamp + " - nicht installiert"
		}
		
	}else{
		$status = $timestamp + " - Keine Auswahl für install definiert"
	
	}
	$outarray += New-Object PsObject -property @{
		'programm' = $programm
		'install' = $install
		'description' = $description
		'status' = $status
		
		
	}

}

#export to .csv file
$outarray | Select-Object "programm", "install", "description", "status" | export-csv $csvdatapath -delimiter ";" -NoTypeInformation

#$officepakt = "7zip","notepadplusplus","office365proplus","googlechrome","paint.net","firefox","adblockpluschrome","adblockplusfirefox","adblockplusie"
#$keepasspakt = "keepass","keepass-keepasshttp","chromelpass-chrome"
#$codingpakt = "notepadplusplus","winscp","putty","vscode","win32diskimager"
#$gamingpakt = "steam","teamspeak","discord","uplay","battle.net","Origin" 
#$socialpakt = "twitch"
#$systempakt = "7zip","ccleaner","crystaldiskinfo"




