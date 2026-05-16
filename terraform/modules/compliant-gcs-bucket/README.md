# Compliant GCS Bucket Module

This Terraform module creates a compliant Google Cloud Storage bucket protected by a customer-managed encryption key.

## Controls Enforced

| Control | Implementation |
|---|---|
| SC-12 | Creates and manages a Cloud KMS key with 90-day rotation |
| SC-13 | Uses a customer-managed encryption key for cryptographic protection |
| SC-28 | Encrypts bucket data at rest using CMEK |
| AU-11 | Enables object versioning and retention policy |
| CM-6 | Applies required compliance labels and hardcoded configuration defaults |
| AC-3 | Enforces uniform bucket-level access and public access prevention |

## Compliance Defaults

The module hardcodes the security floor so consumers cannot disable it:

- Uniform bucket-level access is enabled
- Public access prevention is enforced
- Object versioning is enabled
- Retention policy is required
- CMEK encryption is required
- Required compliance labels are always merged onto the bucket
- KMS key rotation is set to 90 days

## Evidence Output

The module emits a `compliance_attestation` output that downstream labs can consume as evidence.
