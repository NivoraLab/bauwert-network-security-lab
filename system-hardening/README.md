# System Hardening – Linux & Windows

## Overview

This section documents the system-hardening activities performed during the BauWert Network Security Lab (ÜK 184).

The objective was to reduce potential attack surfaces, strengthen system configurations, and evaluate security controls in Linux and Windows environments.

The work was based on established security principles, including least privilege, secure configuration, and defence in depth.

## 1. Ubuntu Server Hardening

An Ubuntu Server was used to examine and implement security measures for a Linux-based server environment.

### SSH Security

The SSH configuration was reviewed and hardened using the following settings:

| Setting | Configuration | Purpose |
|---|---|---|
| PermitRootLogin | no | Disable direct root login |
| MaxAuthTries | 3 | Limit authentication attempts per connection |
| X11Forwarding | no | Disable unnecessary X11 forwarding |

The effective SSH configuration was checked using `sshd -T`.

### UFW Firewall

Ubuntu's Uncomplicated Firewall (UFW) was used to restrict network access.

The configuration included reviewing firewall rules, limiting SSH connection attempts, and restricting unnecessary services.

Example command:

`sudo ufw limit 22/tcp`

This applies rate limiting to SSH connections rather than completely blocking administrative access.

### Security Updates

Automatic security updates were examined using `unattended-upgrades`.

The objective was to reduce exposure to known vulnerabilities by keeping relevant software packages updated.

### AppArmor

AppArmor was examined as an additional application security mechanism.

The command `aa-status` was used to inspect the status of loaded security profiles.

## 2. Windows System Hardening

Windows security controls were examined to evaluate protection against malware, ransomware, unauthorized access, and insecure system configurations.

### Security Controls

| Component | Security Objective |
|---|---|
| Microsoft Defender | Malware and threat protection |
| Windows Firewall | Network traffic filtering |
| Controlled Folder Access | Protection against unauthorized file modifications |
| Microsoft Defender SmartScreen | Protection against suspicious applications and downloads |
| Windows Update | Security patch management |
| Account Policies | Password and account security |
| User Privileges | Review of administrative permissions |

### Account Security

Local account policies were examined using the Windows command:

`net accounts`

Administrative group membership was also reviewed to identify potential risks associated with excessive privileges.

## 3. Security Verification

The system-hardening activities included reviewing configuration settings, checking effective security policies, and examining the accessibility of network services.

The results were documented through configuration outputs and screenshots.

Some measures were evaluated rather than fully enforced. The original project documentation distinguishes between implemented configurations, reviewed settings, and recommendations.

## 4. Security Standards

The activities were informed by established security guidance, including:

- BSI IT-Grundschutz
- CIS Benchmarks
- Microsoft Security Baselines

These resources provided guidance for secure system configuration and risk reduction.

## 5. Key Learning Outcomes

This part of the project strengthened our understanding of:

- Linux server administration
- Secure SSH configuration
- Host-based firewall management
- Automated security updates
- Application security mechanisms
- Windows endpoint protection
- Account security and least privilege
- Verification of security configurations

## Limitations

The configurations were examined in controlled educational test environments.

The documented measures demonstrate selected hardening practices and do not represent a complete production security baseline.

---

**Project:** BauWert Network Security Lab

**Module:** ÜK 184 – Implementing Network Security

**Final Grade:** 6.0 / 6.0
