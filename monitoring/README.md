
# Security Monitoring & Syslog Analysis

This directory contains Python and PowerShell scripts developed for the BauWert Network Security Lab.

## Components

- Python-based UDP Syslog receiver
- Automated monitoring of network interface events
- Detection of repeated interface failures
- PowerShell scripts for offline Syslog analysis
- Event correlation and duplicate detection

## Monitoring Approach

The Python monitoring solution processes incoming Syslog messages and detects repeated interface failures within a five-minute window.

The PowerShell scripts analyse exported Syslog events from Cisco Packet Tracer and demonstrate rule-based alert detection.

## Purpose

These scripts demonstrate practical approaches to network monitoring, log analysis, security event detection, and automation in a controlled lab environment.

## Disclaimer

These tools were developed for educational purposes and are not intended for production deployment without further security review and testing.
