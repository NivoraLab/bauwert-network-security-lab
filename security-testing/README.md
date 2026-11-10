# Network Security Testing – Kali Linux & Nmap

## Overview

This section documents network security assessments performed in a controlled VMware laboratory environment as part of the BauWert Network Security Lab.

Kali Linux and Nmap were used to analyse network accessibility, identify exposed services, and evaluate the effects of firewall configuration changes on an Ubuntu Server.

## Test Environment

| Component | Purpose |
|---|---|
| Kali Linux | Security testing workstation |
| Nmap | Network and port scanning |
| Ubuntu Server | Target system |
| UFW | Host-based firewall |
| VMware Workstation | Virtualized laboratory environment |

## Port Scanning and Firewall Validation

We performed Nmap scans before and after applying firewall restrictions to the Ubuntu Server.

### Initial Assessment

The initial scans were used to examine reachable services and identify the server's exposed network ports.

### Firewall Hardening

We reviewed the Ubuntu Server's firewall configuration and applied restrictions using UFW.

SSH access was retained for administration.

### Verification

Additional Nmap scans were performed to compare the server's network exposure before and after the firewall changes.

The results showed the impact of firewall filtering while maintaining the required SSH connectivity.

## Key Learning Outcomes

- Network reconnaissance using Nmap
- Understanding open, closed, and filtered ports
- Configuring and validating UFW firewall rules
- Comparing network accessibility before and after security changes
- Understanding the importance of verifying security controls through practical testing

## Limitations

The assessments were conducted exclusively in an authorized, isolated educational laboratory environment.

The scan results demonstrate observed network behaviour within this environment and do not constitute a complete security assessment.

## Project Information

**Module:** ÜK 184 – Implementing Network Security

**Project:** BauWert Network Security Lab

**Final Grade:** 6.0 / 6.0
