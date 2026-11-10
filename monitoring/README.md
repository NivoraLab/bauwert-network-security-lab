# Security Monitoring & Syslog Analysis

## Overview

This directory contains Python and PowerShell scripts developed as part of the BauWert Network Security Lab (ÜK 184).

The objective was to implement centralized Syslog collection, analyse network events, identify repeated interface failures, and generate automated alerts.

The project uses two complementary monitoring approaches:

- **Python:** Real-time Syslog reception and automated alert monitoring on Debian Linux.
- **PowerShell:** Offline analysis of exported Cisco Packet Tracer Syslog events.

## Project Files

| File | Description |
|---|---|
| `syslog_empfaenger.py` | Receives Syslog messages over UDP port 5514 |
| `alarm_monitor.py` | Monitors new events and generates alerts |
| `E1_Syslog_Alarmregel_Ereignisfolge (1).ps1` | Analyses event sequences and filters duplicates |
| `E1_Router1_Syslog_Test5_Ereignisfolge.txt` | Sample Syslog events for testing |
| `monitoring-alert-detected.png` | Screenshot of the original monitoring tests |

## 1. Python Syslog Receiver

**Environment:** Debian Linux with Python 3

The Python receiver listens on a configured network interface and stores incoming Syslog messages in a local log file.

Configuration used in the original lab:

- Listening address: `10.184.1.20`
- UDP port: `5514`
- Log file: `~/UEK184/Syslog-Monitoring/syslog.log`

### Setup

Create the required directory:

`mkdir -p ~/UEK184/Syslog-Monitoring`

Create an empty log file:

`touch ~/UEK184/Syslog-Monitoring/syslog.log`

Ensure that the configured IP address exists on the Linux host. Otherwise, modify the `HOST` variable in `syslog_empfaenger.py` to match your lab environment.

Start the receiver from the repository's `monitoring` directory:

`python3 syslog_empfaenger.py`

The receiver displays incoming Syslog messages and writes them to the log file.

## 2. Automated Alert Monitoring

The `alarm_monitor.py` script analyses newly received Syslog events.

It detects interface status changes and records repeated failures.

**Alert conditions:**

- Two separate interface failures
- Same source IP address and network interface
- Within a five-minute monitoring window

Repeated DOWN messages without an intervening UP event are ignored to prevent duplicate alerts.

Start the monitoring script in a second terminal:

`python3 alarm_monitor.py`

Detected alerts are written to:

`~/UEK184/Syslog-Monitoring/alarme.log`

The monitoring script reads new log entries from the end of the file. Previously stored messages are not processed when the script starts.

## 3. PowerShell Syslog Analysis

The PowerShell script provides an offline analysis of exported Cisco Packet Tracer events.

It evaluates interface failures, event sequences, and duplicate messages.

The script preserves event order when multiple messages have identical timestamps.

### Example

Open PowerShell in the `monitoring` directory and execute:

`.\E1_Syslog_Alarmregel_Ereignisfolge (1).ps1 -LogDatei "E1_Router1_Syslog_Test5_Ereignisfolge.txt"`

If PowerShell blocks script execution, review the local execution policy before running the script.

The sample log contains the following sequence:

1. Interface DOWN
2. Interface UP
3. Interface DOWN

The expected result is an alert indicating two separate interface failures within five minutes.

## 4. Monitoring Test Evidence

![Syslog Alert Detection](monitoring-alert-detected.png)

The screenshot shows the original PowerShell test results, including successful alarm detection and duplicate-event handling.

## 5. Limitations

- The Python scripts use a fixed laboratory IP address and directory structure.
- The receiver uses UDP, which does not guarantee message delivery.
- The PowerShell analysis processes exported log files rather than live Packet Tracer events.
- These scripts are educational prototypes and require additional testing, error handling, and security controls before production use.

## Key Learning Outcomes

This implementation provided practical experience with:

- Linux system administration
- Python socket programming
- Centralized Syslog collection
- Automated security event analysis
- PowerShell scripting
- Event correlation and duplicate detection
- Network monitoring and troubleshooting

**Project:** BauWert Network Security Lab  
**Module:** ÜK 184 – Implementing Network Security  
**Final Grade:** 6.0 / 6.0
