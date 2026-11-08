# BauWert – Network Security Lab

**Cisco Packet Tracer | Network Security | Cybersecurity | System Hardening**

**Final Grade: 6.0 / 6.0 (Highest Swiss Grade)**

## Project Overview

This project focuses on analysing, designing, implementing, and evaluating the network security infrastructure of BauWert GmbH, a fictional Swiss construction company.

The project was based on a ransomware attack scenario called **"Blackout"**, involving compromised user credentials, lateral movement, data exfiltration, and the encryption of critical company systems.

Our objective was to identify security vulnerabilities, assess potential risks, implement appropriate security controls, and verify their effectiveness through practical testing.

The project was completed by a two-person team as part of the Swiss **ICT Specialist EFZ (Platform Development)** vocational training programme.

**Final Project Grade: 6.0 / 6.0**

## Technologies & Tools

| Technology | Purpose |
|---|---|
| Cisco Packet Tracer | Network simulation and security testing |
| Cisco ASA Firewall | Firewall configuration and access control |
| Cisco ISR Routers | Network routing and VPN configuration |
| VLANs | Network segmentation |
| DMZ | Isolation of selected network services |
| IPsec VPN | Secure remote access |
| Access Control Lists (ACLs) | Traffic filtering and access restrictions |
| Ubuntu Server | Linux system hardening |
| Windows | Endpoint security and account policies |
| Syslog | Security event logging and monitoring |
| VMware Workstation | Virtualized test environment |

## Project Objectives

The main objectives were to:

- Analyse the existing network infrastructure and identify vulnerabilities.
- Evaluate and prioritize cybersecurity risks.
- Design a secure network architecture using segmentation and security zones.
- Implement firewall rules and restricted remote access.
- Apply system-hardening measures to Linux and Windows environments.
- Perform security tests and document the results.
- Analyse security logs and monitor network activity.
- Troubleshoot connectivity issues using a structured methodology.

## Project Implementation

The project covered nine competency areas.

| Area | Description |
|---|---|
| A1 | Analyse the existing IT infrastructure |
| A2 | Identify vulnerabilities and assess risks |
| B1 | Design a secure network architecture |
| B2 | Develop security concepts for VPN, remote access, and intrusion detection |
| C1 | Configure network security components |
| C2 | Harden Linux and Windows systems |
| D1 | Perform and document security tests |
| E1 | Monitor and analyse security-related events |
| F1 | Troubleshoot and resolve network connectivity issues |

## Network Security Architecture

We designed a segmented network architecture to reduce the risk of unauthorized access and lateral movement.

Key security measures included:

- Separation of network segments using VLANs
- DMZ architecture for selected services
- Firewall access control policies
- Restricted VPN access for remote users
- Separation of client and server networks
- Centralized security event logging
- Application of the principle of least privilege

The architecture was designed to limit unnecessary communication between security zones while maintaining access to authorized services.

## Security Testing & Validation

We tested the implemented security controls using connectivity tests, configuration checks, and packet-level analysis.

The tests focused on verifying whether legitimate traffic was permitted and unauthorized connections were restricted.

Cisco Packet Tracer's simulation mode helped us investigate packet flows and evaluate network behaviour.

### Troubleshooting Case: VPN Connectivity Failure

One of the most challenging tasks involved troubleshooting an IPsec VPN connection.

**Problem:**

The VPN tunnel was successfully established, but the remote client could not access the internal server (Server0) over HTTPS.

**Investigation:**

We analysed several components:

- Firewall ACL hit counters
- IPsec encryption and decryption counters
- Routing tables
- ARP behaviour
- Packet flows in Cisco Packet Tracer

**Resolution:**

The investigation revealed a problem with the return path of network packets, involving the ASA's ARP behaviour.

We resolved the connectivity issue by introducing a dedicated VPN network zone without weakening the existing firewall security policies.

**Key Learning:**

A successful VPN connection does not automatically guarantee end-to-end connectivity. Routing, ARP resolution, firewall rules, and return traffic must all be evaluated.

## System Hardening

We examined and applied security-hardening measures in Linux and Windows environments.

The work included:

- Reviewing user privileges and account security
- Securing SSH configurations
- Restricting unnecessary network services
- Reviewing firewall policies
- Examining automatic security updates
- Evaluating Windows security settings

Security recommendations were considered with reference to established frameworks, including BSI IT-Grundschutz and CIS Benchmarks.

## Limitations

Some security features could not be fully implemented within Cisco Packet Tracer.

These included:

- Multi-factor authentication (MFA)
- Certain intrusion prevention system (IPS) capabilities
- Selected firewall and IPsec commands

These measures were documented conceptually rather than presented as fully implemented security controls.

The simulated environment is intended for educational purposes and does not represent a production-ready enterprise security solution.

## Key Takeaways

This project strengthened our practical knowledge of:

- Network security architecture
- Cisco routing and firewall configuration
- VPN technologies and troubleshooting
- Linux and Windows system hardening
- Security testing and network monitoring
- Structured fault analysis
- Technical documentation
- Collaboration and project coordination

One of the most important lessons was learning to investigate technical issues using measurable evidence instead of making assumptions.

## Project Results

**Status:** Completed – November 2026

**Team:** Two students

**Module:** ÜK 184 – Implementing Network Security

**Final Grade:** 6.0 / 6.0 – Highest Swiss Grade

The project successfully combined theoretical cybersecurity concepts with practical network configuration, testing, troubleshooting, and documentation.

## Disclaimer

This repository documents a fictional business environment developed for educational purposes.

The network topology, security configurations, and documented attack scenarios are intended for controlled simulation and learning.

Some security measures are conceptual or limited by the capabilities of Cisco Packet Tracer. The project should not be considered a production-ready security implementation.
