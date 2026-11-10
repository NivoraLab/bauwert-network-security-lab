# BauWert – Network Security Lab

**Network Security | Cisco Packet Tracer | Python | PowerShell | Linux**

**Final Grade: 6.0 / 6.0 – Highest Swiss Grade**

A hands-on cybersecurity project focused on securing the network infrastructure of a fictional construction company against ransomware, unauthorized access, and lateral movement.

Completed as a two-person team project during the Swiss vocational training programme in Computer Science (Platform Development).

## Network Architecture

![BauWert Network Topology](topology/bauwert-final-lab-topology.png)

The network simulation includes a Cisco ASA firewall, routers, switches, internal servers, a DMZ, wireless networks, a VPN gateway, and a central logging server.

The architecture was designed around network segmentation, restricted access between security zones, and the principle of least privilege.

## Project Overview

The project was based on a ransomware scenario called **Blackout**.

The simulated attack involved compromised credentials, unauthorized network access, data exfiltration, and the encryption of business-critical systems.

Our objective was to analyse the existing infrastructure, identify vulnerabilities, design security measures, implement selected controls, and validate the results.

### Technologies & Tools

| Technology | Application |
|---|---|
| Cisco Packet Tracer | Network simulation and testing |
| Cisco ASA & ISR Routers | Firewall, routing and VPN configuration |
| VLANs & DMZ | Network segmentation |
| IPsec VPN | Secure remote access |
| ACLs | Traffic filtering |
| Ubuntu Server | Linux system hardening |
| Windows | Endpoint security |
| Python | Syslog reception and alert monitoring |
| PowerShell | Security log analysis |
| VMware Workstation | Virtualized test environment |
| Kali Linux & Nmap | Network scanning, port analysis and firewall validation in an isolated VMware lab |
| Debian 13 | Centralized Syslog collection, Python-based monitoring and automated alert detection |

## Implementation

The project covered nine competency areas, from A1 to F1.

| Phase | Focus |
|---|---|
| A1–A2 | Infrastructure analysis and risk assessment |
| B1–B2 | Network architecture and security design |
| C1–C2 | Security implementation and system hardening |
| D1 | Security testing and validation |
| E1 | Monitoring and log analysis |
| F1 | Network troubleshooting and fault resolution |

## Linux Security Testing Environment

In addition to the Cisco Packet Tracer simulation, we established separate VMware-based Linux test environments.

**Kali Linux & Nmap**

Kali Linux was used to perform network security assessments against an Ubuntu Server. Using Nmap, we examined open and filtered ports, compared results from different virtual network zones, and evaluated the effects of UFW firewall rules.

**Debian 13 & Syslog Monitoring**

Debian 13 was configured as a centralized Syslog receiver, collecting log messages from an Ubuntu Server 24.04 environment over UDP port 5514.

Custom Python scripts were used to process incoming messages, detect repeated network interface failures, filter duplicate events, and generate automated alerts.

These additional environments provided hands-on experience in Linux administration, network security testing, and security monitoring beyond the capabilities of Cisco Packet Tracer.

## Security Monitoring

We developed Python and PowerShell scripts for collecting and analysing Syslog messages.

The monitoring implementation focuses on detecting repeated network interface failures and evaluating event sequences.

![Syslog Alert Detection](monitoring/monitoring-alert-detected.png)

The repository includes example monitoring scripts and sample event data in the [`monitoring/`](monitoring/) directory.

## VPN Troubleshooting

One of the most challenging tasks was investigating an IPsec VPN connectivity issue.

**Problem:** The VPN tunnel was established during the original project tests, but HTTPS communication with the internal server initially failed.

We investigated the issue using:

- Firewall ACL hit counters
- IPsec packet counters
- Routing tables
- ARP analysis
- Cisco Packet Tracer simulation mode

### Packet Flow Analysis

![VPN Packet Flow](topology/vpn-zone-packet-path.png)

The investigation identified an issue involving the return path of VPN traffic and the ASA's ARP behaviour.

A dedicated VPN zone was introduced to resolve the issue without unnecessarily relaxing firewall security policies.

### Original HTTPS Test Evidence

![HTTPS Connectivity Test](topology/vpn-https-success.png)

The screenshot documents the successful HTTPS test recorded during the original F1 project work.

**Verification note:** A later attempt to reconnect using the archived Packet Tracer file timed out during VPN negotiation. The original test evidence is therefore presented as a historical project result, not as a newly reproduced test.

## Security Limitations

Some security measures could not be fully implemented within Cisco Packet Tracer.

These included multi-factor authentication (MFA) and selected intrusion prevention system (IPS) capabilities.

Such measures were documented conceptually and distinguished from practically implemented controls.

## Key Learning Outcomes

This project strengthened our skills in network architecture, firewall configuration, secure remote access, Linux and Windows hardening, automated monitoring, and systematic troubleshooting.

A key lesson was the importance of analysing packet flows and interpreting measurable evidence rather than making assumptions about the source of a network problem.

## Project Results

**Module:** ÜK 184 – Implementing Network Security

**Status:** Completed, November 2026

**Team:** Two students

**Final Grade:** 6.0 / 6.0 (Highest Swiss Grade)

## Disclaimer

This repository documents a fictional business environment created for educational purposes.

The simulations and scripts are intended for controlled laboratory use and should not be considered production-ready security implementations.
