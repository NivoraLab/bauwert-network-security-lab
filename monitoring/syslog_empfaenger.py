import socket
from datetime import datetime
from pathlib import Path

HOST = "10.184.1.20"
PORT = 5514

LOGDATEI = Path.home() / "UEK184/Syslog-Monitoring/syslog.log"

sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
sock.bind((HOST, PORT))

print(f"Syslog-Empfaenger gestartet: {HOST}:{PORT}")
print("Zum Beenden Ctrl+C druecken.")

try:
    while True:
        daten, adresse = sock.recvfrom(4096)
        meldung = daten.decode("utf-8", errors="replace")

        zeit = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
        eintrag = f"{zeit} | {adresse[0]} | {meldung}"

        print(eintrag, flush=True)

        with LOGDATEI.open("a", encoding="utf-8") as datei:
            datei.write(eintrag + "\n")

except KeyboardInterrupt:
    print("\nSyslog-Empfaenger beendet.")

finally:
    sock.close()
