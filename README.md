# psautoinstaller
Automatisches Powershell Installationskript mit chocolatey

# Installation

- Download und Entpacken des Skripts 
- in der CSV-Datei auswählen welche Programme installiert werden sollen. (1 = installieren / 0 = deinstallieren)
- Administrativen Powershell im Verzeichnis öffnen 
- .\install.ps1 starten (s.a. FAQs)
- Es werden die ausgewählen Programme installiert, falls diese noch nicht installiert sind
- Automatisches Update wird bei Systemstart per Geplanter Task ausgeführt

Viel Spaß mit automatisch aktualisierter Software!

# FAQ

##### Welche Programme muss ich auswählen?
Alle Programme die du installieren und updaten möchtest. Wenn du schon Anwendungen in der Liste installiert hast wähle bei diesen auch den Status "1" aus oder löschen den Eintrag aus der CSV-Datei. Ansonsten werden diese Anwendung deinstalliert.

##### Werde die Programme jetzt dann automatisch geupdatet?
Die Programme über das Skript installiert wurden werden automatisch geupdatet, wenn du das Paket **choco-upgrade-all-at-startup** installierst. Dann wird ein geplanter Taks angelegt, der bei jeden Computerstart nach Updates prüft.

##### Das install.ps1 Skript startet nicht!
Das kann passieren, wenn die Skriptausführung verhindert wurde. Dieses ist eine Windows Standardeinstellung.
Starte das Skript in der PowerShell dann so in dem Ordner: 
```
Set-ExecutionPolicy Bypass -Scope Process -Force; .\install.ps1
```
##### Das Skript gibt keine Rückmeldung!
Schaue nach der Ausführung in die CSV-Datei. Dort findest du dann die Rückmeldungen des Skripts zum jeden Programm.
