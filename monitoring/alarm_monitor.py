import re
import time
from pathlib import Path
from datetime import datetime
from collections import defaultdict, deque

ORDNER = Path.home() / "UEK184/Syslog-Monitoring"
LOGDATEI = ORDNER / "syslog.log"
ALARMDATEI = ORDNER / "alarme.log"

ZEITFENSTER = 300  # 5 Minuten

muster = re.compile(
    r"Interface\s+([^,\s]+),\s+changed state to\s+(down|up)",
    re.IGNORECASE
)

zustaende = {}
ausfaelle = defaultdict(deque)

print("UEK184 - Automatische Alarmueberwachung gestartet")
print("Alarmregel: 2 Ausfaelle innerhalb von 5 Minuten")
print("Warte auf neue Syslog-Ereignisse...")
print("Beenden mit Ctrl+C")

try:
    with LOGDATEI.open("r", encoding="utf-8") as datei:
        # Bereits gespeicherte Ereignisse nicht erneut auswerten
        datei.seek(0, 2)

        while True:
            zeile = datei.readline()

            if not zeile:
                time.sleep(0.2)
                continue

            treffer = muster.search(zeile)

            if not treffer:
                continue

            teile = zeile.split(" | ", 2)

            if len(teile) != 3:
                continue

            quelle = teile[1]
            interface = treffer.group(1)
            status = treffer.group(2).lower()

            schluessel = (quelle, interface)

            if status == "up":
                zustaende[schluessel] = "up"
                print(f"OK: {quelle} {interface} ist UP", flush=True)
                continue

            if zustaende.get(schluessel) == "down":
                print("Duplikat DOWN ignoriert", flush=True)
                continue

            zustaende[schluessel] = "down"

            jetzt = time.monotonic()
            fenster = ausfaelle[schluessel]

            while fenster and jetzt - fenster[0] > ZEITFENSTER:
                fenster.popleft()

            fenster.append(jetzt)

            print(
                f"DOWN: {quelle} {interface} "
                f"({len(fenster)} Ausfaelle im Zeitfenster)",
                flush=True
            )

            if len(fenster) >= 2:
                zeit = datetime.now().strftime("%Y-%m-%d %H:%M:%S")

                alarm = (
                    f"{zeit} | ALARM | {quelle} | {interface} | "
                    f"{len(fenster)} Ausfaelle innerhalb von 5 Minuten"
                )

                print(alarm, flush=True)

                with ALARMDATEI.open("a", encoding="utf-8") as datei_alarm:
                    datei_alarm.write(alarm + "\n")

except KeyboardInterrupt:
    print("\nAlarmueberwachung beendet.")
