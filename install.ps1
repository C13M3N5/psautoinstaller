
if($all){
  $socialmedia = $true
  $games = $true
}

Install Chocolatey
Set-ExecutionPolicy Bypass -Scope Process -Force; iwr https://chocolatey.org/install.ps1 -UseBasicParsing | iex

## Install Notepad++
choco install notepadplusplus -y

## Install WinSCP
choco install winscp -y

## Office 365
choco install office365proplus

## Keepass
choco install keepass
choco install keepass-keepasshttp

## Chrome
choco install chromelpass-chrome

## Putty
choco install putty

## Paint.net
choco install paint.net

## Games
if($steam -or $games){
  ## Steam Client
  choco install steam
}
if($teamspeak -or $games)
  ## Teamspeak Client
  choco install teamspeak
}

## Social Media
# Twitch
if($twitch -or $soicalmedia){
  choco install twitch
}






