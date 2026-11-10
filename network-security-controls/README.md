
# Network Security Controls – Cisco Packet Tracer

## Overview

This section documents the network security controls designed, configured and tested during the BauWert Network Security Lab (ÜK 184).

The focus was on network segmentation, firewall access control, DMZ protection and verification of permitted and restricted traffic.

## 1. Network Segmentation

We designed separate security zones for different network functions, including:

- Office workstations
- Internal servers
- Employee and guest wireless networks
- DMZ services
- Remote VPN connectivity

VLANs and firewall policies were used to control communication between the network segments.

## 2. Firewall Configuration

Cisco ASA firewall configurations and Access Control Lists (ACLs) were examined and modified to restrict unnecessary network access.

The configuration followed the principle of least privilege.

We investigated how firewall rules affect both incoming traffic and return traffic.

During troubleshooting, an explicit deny rule caused a connectivity problem that required further analysis and correction.

## 3. DMZ Security

A DMZ was configured for an externally accessible web server.

The documented tests included:

- Successful HTTPS access to the DMZ web server
- Restricted HTTP access
- Access restrictions between the DMZ and internal networks
- Verification of routing and firewall behaviour

## 4. Security Testing

Connectivity tests were performed using Cisco Packet Tracer.

The tests examined whether authorized communication was possible and whether restricted connections were blocked.

Methods included:

- ICMP connectivity tests
- HTTP and HTTPS connection tests
- Firewall ACL hit-counter analysis
- Packet Tracer simulation mode
- Packet-flow investigation

A failed connection alone was not considered sufficient evidence of a correctly enforced firewall rule. Configuration and packet-flow evidence were also considered.

## 5. Lessons Learned

The project demonstrated the importance of combining network segmentation with properly configured firewall policies.

We learned that overly restrictive rules can interrupt legitimate communication, while overly permissive rules can weaken network security.

Systematic testing and careful interpretation of packet flows were essential for validating the implemented controls.

## Limitations

The results are based on an educational Cisco Packet Tracer simulation.

Some security functions could not be reproduced completely, and the documented tests do not represent a full production security assessment.

---

**Project:** BauWert Network Security Lab  
**Module:** ÜK 184 – Implementing Network Security  
**Final Grade:** 6.0 / 6.0
