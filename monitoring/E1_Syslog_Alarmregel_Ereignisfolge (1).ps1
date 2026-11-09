# UEK 184 - E1 Advanced: Offline-Syslog-Alarmregel mit Ereignisfolge
# ZWECK: Mehrere Ausfaelle derselben Quelle und Schnittstelle innerhalb
# eines Zeitfensters erkennen, auch wenn Packet Tracer gleiche Zeitstempel
# fuer verschiedene Statuswechsel vergibt.
# DATENQUELLE: Manuell aus Packet Tracer uebernommene Syslog-Eintraege.
# KEIN Live-Monitoring und KEIN Alarm direkt im Packet-Tracer-Syslog-Server.

[CmdletBinding()]
param(
    [string]$LogDatei = 'E1_Router1_Syslog_Test5_Ereignisfolge.txt',
    [ValidateRange(1, 60)]
    [int]$FensterMinuten = 5
)

$ErrorActionPreference = 'Stop'

if ([System.IO.Path]::IsPathRooted($LogDatei)) {
    $pfad = $LogDatei
} else {
    $pfad = Join-Path -Path $PSScriptRoot -ChildPath $LogDatei
}

if (-not (Test-Path -LiteralPath $pfad -PathType Leaf)) {
    Write-Host "FEHLER: Logdatei nicht gefunden: $pfad" -ForegroundColor Red
    exit 1
}

# Sowohl down- als auch up-Meldungen einlesen. Die Zeilennummer ist wichtig:
# bei gleichen Zeitstempeln darf die Reihenfolge nicht verloren gehen.
$ausdruck = '^(?<Zeit>\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2}\.\d{3})\s*\|\s*(?<Quelle>\d+\.\d+\.\d+\.\d+)\s*\|\s*%LINEPROTO-5-UPDOWN:\s*Line protocol on Interface (?<Interface>[^,]+), changed state to (?<Zustand>down|up)\s*$'
$ereignisse = New-Object 'System.Collections.Generic.List[object]'
$zeilennummer = 0

foreach ($zeile in (Get-Content -LiteralPath $pfad -Encoding UTF8)) {
    $zeilennummer++
    $treffer = [regex]::Match($zeile, $ausdruck)
    if (-not $treffer.Success) { continue }

    $ereignisse.Add([pscustomobject]@{
        Zeit      = [datetime]::ParseExact($treffer.Groups['Zeit'].Value, 'yyyy-MM-dd HH:mm:ss.fff', [Globalization.CultureInfo]::InvariantCulture)
        Quelle    = $treffer.Groups['Quelle'].Value
        Interface = $treffer.Groups['Interface'].Value.Trim()
        Zustand   = $treffer.Groups['Zustand'].Value
        Zeile     = $zeilennummer
    })
}

# Nur nach Zeitpunkt und anschliessend Zeilenposition sortieren.
# Dadurch bleibt down -> up -> down bei identischem Zeitstempel erhalten.
$sortiert = @($ereignisse | Sort-Object -Property Zeit, Zeile)
$zustandJeSchnittstelle = @{}
$ausfaelleJeSchnittstelle = @{}
$rohAusfaelle = 0
$eindeutigeAusfaelle = 0
$duplikate = 0
$alarmNachweis = $null

foreach ($ereignis in $sortiert) {
    $schluessel = "$($ereignis.Quelle)|$($ereignis.Interface)"
    if (-not $zustandJeSchnittstelle.ContainsKey($schluessel)) {
        $zustandJeSchnittstelle[$schluessel] = [pscustomobject]@{
            LetzterDownZeitpunkt = $null
            UpSeitLetztemDown   = $false
        }
        $ausfaelleJeSchnittstelle[$schluessel] = New-Object 'System.Collections.Generic.List[datetime]'
    }
    $zustand = $zustandJeSchnittstelle[$schluessel]

    if ($ereignis.Zustand -eq 'up') {
        # Eine beobachtete Wiederherstellung trennt zwei Ausfaelle,
        # selbst wenn sie laut Simulation denselben Zeitstempel haben.
        $zustand.UpSeitLetztemDown = $true
        continue
    }

    $rohAusfaelle++
    $istDuplikat = ($null -ne $zustand.LetzterDownZeitpunkt -and
                    $ereignis.Zeit -eq $zustand.LetzterDownZeitpunkt -and
                    -not $zustand.UpSeitLetztemDown)

    if ($istDuplikat) {
        $duplikate++
        continue
    }

    $eindeutigeAusfaelle++
    $zustand.LetzterDownZeitpunkt = $ereignis.Zeit
    $zustand.UpSeitLetztemDown = $false
    $ausfaelleJeSchnittstelle[$schluessel].Add($ereignis.Zeit)

    $fensterBeginn = $ereignis.Zeit.AddMinutes(-$FensterMinuten)
    $anzahlImFenster = @($ausfaelleJeSchnittstelle[$schluessel] | Where-Object {
        $_ -ge $fensterBeginn -and $_ -le $ereignis.Zeit
    }).Count

    if ($null -eq $alarmNachweis -and $anzahlImFenster -ge 2) {
        $alarmNachweis = [pscustomobject]@{
            Quelle    = $ereignis.Quelle
            Interface = $ereignis.Interface
            Anzahl    = $anzahlImFenster
            Zeit      = $ereignis.Zeit
        }
    }
}

Write-Host "Logdatei: $([System.IO.Path]::GetFileName($pfad))"
Write-Host "Ausfallmeldungen erkannt: $rohAusfaelle"
Write-Host "Unterschiedliche Ausfaelle: $eindeutigeAusfaelle"
Write-Host "Entfernte Duplikate: $duplikate"

if ($null -ne $alarmNachweis) {
    Write-Host "ALARM: $($alarmNachweis.Anzahl) Ausfaelle an $($alarmNachweis.Quelle) / $($alarmNachweis.Interface) innerhalb von $FensterMinuten Minuten (bis $($alarmNachweis.Zeit.ToString('HH:mm:ss')))." -ForegroundColor Red
} else {
    Write-Host "OK: Kein Alarm. Weniger als 2 Ausfaelle derselben Schnittstelle innerhalb von $FensterMinuten Minuten." -ForegroundColor Green
}

# Grenze: Wiederholte 'down'-Meldungen mit verschiedenem Zeitstempel
# koennen ohne passende 'up'-Meldung nicht sicher als separate Ausfaelle
# oder erneut versandte Meldungen unterschieden werden.
