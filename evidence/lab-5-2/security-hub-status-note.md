# Lab 5.2 Security Hub Status Note

Security Hub was enabled successfully with the following standards:

- NIST 800-53 Rev 5
- AWS Foundational Security Best Practices

The enabled standards returned INCOMPLETE status with the reason:

NO_AVAILABLE_CONFIGURATION_RECORDER

This indicates that AWS Config is not currently available/enabled for the account. The lab allows this condition to be documented as evidence when Config is unavailable or centrally managed.

Security Hub findings were initially captured, but the first findings batch may take 10 to 30 minutes to populate after first enablement.
