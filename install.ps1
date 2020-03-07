$all = $true
if($all){
  $socialmedia = $true
  $games = $true
  $coding = $true
  $systeminfo = $true
}

## Install Chocolatey
Set-ExecutionPolicy Bypass -Scope Process -Force; iwr https://chocolatey.org/install.ps1 -UseBasicParsing | iex

## 7zip
choco install 7zip -y

## cccleaner
choco install ccleaner -y

## Install Notepad++
choco install notepadplusplus -y

## Install WinSCP
choco install winscp -y

## Office 365
choco install office365proplus -y

## Keepass
choco install keepass -y
choco install keepass-keepasshttp -y

## Chrome
choco install googlechrome -y
choco install chromelpass-chrome -y
choco install adblockpluschrome -y

## Firefox
choco install firefox -y
choco install adblockplusfirefox -y
choco install adblockplusie -y

## Putty
choco install putty -y

## Paint.net
choco install paint.net -y

## Games
if($steam -or $games){
  ## Steam Client
  choco install steam -y
}
if($teamspeak -or $games){
  ## Teamspeak Client
  choco install teamspeak -y
}

## Social Media
# Twitch
if($twitch -or $soicalmedia){
  choco install twitch -y
}

if($vscode -or $coding){
  choco install vscode -y
}

if($windisk -or $coding){
  choco install win32diskimager -y
}

if($diskinfo -or $systeminfo){
  choco install crystaldiskinfo -y
}  

## Autoupdate with Task in Windows
choco install choco-upgrade-all-at-startup -y
