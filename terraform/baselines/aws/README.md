# AWS Security Services Baseline

This Terraform baseline deploys AWS-native security monitoring services for Lab 5.2.

## Services

- AWS CloudTrail
- AWS Security Hub
- Security Hub NIST 800-53 Rev 5 standard
- Security Hub AWS Foundational Security Best Practices standard

## Control Mapping

| Service | Controls | Purpose |
|---|---|---|
| CloudTrail | AU-2, AU-10, AU-12 | Captures management events, enables audit logging, and validates log file integrity |
| Security Hub | RA-5, SI-4 | Aggregates security findings and supports continuous monitoring |
| S3 | AU-9, SC-28, AC-3 | Stores CloudTrail logs with encryption, versioning, and public access blocking |

## Evidence

Evidence for this lab is captured in:

evidence/lab-5-2/security-hub-findings.json

## Cost Note

Security Hub standards may generate AWS charges. Destroy this baseline after capturing evidence if you do not want ongoing charges.