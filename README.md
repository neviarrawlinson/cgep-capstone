# CGE-P Capstone Portfolio

This repository contains hands-on lab work, infrastructure-as-code artifacts, compliance evidence, and supporting scripts completed as part of the GRC Engineering Academy CGE-P certification.

The purpose of this capstone portfolio is to demonstrate practical GRC Engineering skills by translating compliance requirements into technical controls, deploying secure cloud resources with Terraform, and producing machine-readable evidence that can support audit, assurance, and control validation activities.

## Overview

This repository focuses on the intersection of:

- Governance, Risk, and Compliance Engineering
- Infrastructure as Code
- Cloud security control implementation
- Evidence automation
- Compliance-as-code
- Machine-readable audit artifacts
- Secure evidence storage and chain of custody

The labs in this repository show how compliance expectations can be embedded directly into cloud infrastructure, Terraform modules, evidence workflows, and version-controlled technical artifacts.

## Repository Structure

```text
cgep-capstone/
├── evidence/
│   ├── lab-2-3/
│   │   ├── plan.json
│   │   └── state.json
│   ├── lab-2-4/
│   │   ├── compliance_attestation.json
│   │   ├── plan.json
│   │   └── state.json
│   └── lab-2-5/
│       └── receipt.json
├── scripts/
│   └── capture-evidence.sh
├── terraform/
│   ├── modules/
│   │   └── compliant-gcs-bucket/
│   │       ├── main.tf
│   │       ├── variables.tf
│   │       ├── outputs.tf
│   │       └── README.md
│   └── primitives/
│       ├── compliant-s3/
│       │   ├── main.tf
│       │   ├── variables.tf
│       │   ├── outputs.tf
│       │   └── README.md
│       ├── compliant-gcs/
│       │   ├── main.tf
│       │   └── README.md
│       └── evidence-vault/
│           ├── main.tf
│           ├── variables.tf
│           ├── outputs.tf
│           └── README.md
├── .gitignore
└── README.md
```

## Completed Labs

| Lab | Title | Status |
|---|---|---|
| Lab 2.3 | Building Your First Compliant Resource, AWS S3 | Complete |
| Lab 2.4 | Terraform Modules for Compliance, GCP | Complete |
| Lab 2.5 | IaC as Compliance Evidence, AWS | Complete |

## Lab 2.3: Building Your First Compliant Resource, AWS S3

Lab 2.3 builds a compliant AWS S3 storage primitive using Terraform. The implementation creates a primary S3 bucket and a dedicated log bucket with baseline security and compliance controls enforced through code.

### Control Implementation Summary

| Control | Control Objective | Technical Implementation |
|---|---|---|
| SC-28 | Protect information at rest | Enables AES-256 server-side encryption on the primary S3 bucket |
| AU-3 | Generate audit records | Enables S3 server access logging to a dedicated log bucket |
| AU-6 | Support audit review and analysis | Captures Terraform plan and state output as machine-readable evidence |
| CM-6 | Enforce configuration settings | Applies required compliance tags and enables versioning |
| AC-3 | Enforce access control | Blocks all public access paths using S3 public access block settings |

### Evidence Artifacts

```text
evidence/lab-2-3/plan.json
evidence/lab-2-3/state.json
```

These files provide machine-readable evidence of the planned and deployed AWS S3 configuration.

## Lab 2.4: Terraform Modules for Compliance, GCP

Lab 2.4 builds a reusable Terraform module for a compliant Google Cloud Storage bucket. The module enforces a security and compliance baseline while allowing consumers to provide only business-specific inputs such as project ID, environment, retention period, and bucket naming suffix.

### Module Location

```text
terraform/modules/compliant-gcs-bucket/
```

### Consumer Location

```text
terraform/primitives/compliant-gcs/
```

### Control Implementation Summary

| Control | Control Objective | Technical Implementation |
|---|---|---|
| SC-12 | Cryptographic key establishment and management | Creates a Cloud KMS keyring and crypto key with 90-day rotation |
| SC-13 | Cryptographic protection | Uses a customer-managed encryption key for the storage bucket |
| SC-28 | Protect information at rest | Encrypts GCS bucket data using CMEK |
| AU-11 | Retain audit records and data | Enables object versioning and a 30-day retention policy |
| CM-6 | Enforce configuration settings | Applies required compliance labels and hardcoded module defaults |
| AC-3 | Enforce access control | Enables uniform bucket-level access and public access prevention |

### Compliance Attestation

The module emits a `compliance_attestation` output with the following evidence values:

```text
encryption_algorithm
versioning_enabled
public_access_prevention
uniform_access_enforced
retention_period_days
required_labels_present
kms_rotation_period
```

### Evidence Artifacts

```text
evidence/lab-2-4/plan.json
evidence/lab-2-4/state.json
evidence/lab-2-4/compliance_attestation.json
```

These files provide machine-readable evidence of the planned infrastructure, deployed state, and module-generated compliance attestation.

## Lab 2.5: IaC as Compliance Evidence, AWS

Lab 2.5 builds an immutable evidence vault using AWS S3 Object Lock and a Bash capture script. The lab demonstrates how infrastructure-as-code artifacts can become stronger compliance evidence when they are hashed, bundled, versioned, and stored in a retention-protected location.

### Evidence Vault Location

```text
terraform/primitives/evidence-vault/
```

### Capture Script Location

```text
scripts/capture-evidence.sh
```

### Evidence Vault Capabilities

| Evidence Property | Implementation |
|---|---|
| Integrity | Evidence files are hashed using SHA-256 |
| Attribution | Git commit metadata is captured in the evidence bundle |
| Reproducibility | Terraform plan, state, version, and commit data are bundled together |
| Immutability | S3 Object Lock applies retention protection to uploaded bundles |
| Durability | S3 VersionId is recorded in the receipt |
| Access Protection | Public access is blocked and bucket deletion is restricted |
| Encryption | AES-256 server-side encryption is enabled |

### Evidence Receipt

```text
evidence/lab-2-5/receipt.json
```

The receipt records:

```text
run_id
vault
key
version_id
captured_at_utc
```

The `version_id` is especially important because it creates a durable reference to the exact uploaded evidence bundle.

## Evidence Philosophy

This repository demonstrates a shift from manual compliance evidence to automated, machine-readable evidence.

Traditional evidence often depends on screenshots, manual exports, and point-in-time visual proof. This portfolio uses Terraform plans, Terraform state, module outputs, JSON attestations, hashes, object versioning, and retention-protected storage to create evidence that is more repeatable, verifiable, and resistant to silent modification.

The evidence approach in this repository is based on three principles:

| Principle | Meaning |
|---|---|
| Integrity | Evidence should prove it has not changed unexpectedly |
| Attribution | Evidence should show where it came from and what produced it |
| Reproducibility | Evidence should allow reviewers to understand how the result was generated |

## Tools and Technologies

This portfolio uses:

- Terraform
- AWS CLI
- Google Cloud CLI
- AWS S3
- AWS S3 Object Lock
- Google Cloud Storage
- Google Cloud KMS
- Git Bash
- PowerShell
- Git
- GitHub

## Skills Demonstrated

This repository demonstrates the ability to:

- Translate compliance requirements into enforceable cloud controls
- Build secure infrastructure using Terraform
- Design reusable Terraform modules with compliance defaults
- Generate machine-readable compliance evidence
- Capture Terraform plan and state as audit artifacts
- Use compliance attestations as downstream evidence
- Create immutable evidence storage using S3 Object Lock
- Record durable S3 VersionIds for evidence chain of custody
- Structure technical artifacts for audit readiness
- Maintain a clean GitHub portfolio repository without exposing local state or secrets

## Security Notes

Sensitive local files are intentionally excluded from version control through `.gitignore`, including:

```text
.terraform/
*.tfstate
*.tfstate.*
tfplan
terraform.tfvars
*.backup
crash.log
crash.*.log
.aws/
*.pem
*.key
```

This helps prevent accidental exposure of Terraform state, local variable files, credentials, private keys, or environment-specific configuration.

## Current Status

| Area | Status |
|---|---|
| AWS compliant S3 primitive | Complete |
| GCP compliant GCS module | Complete |
| GCP compliant GCS consumer | Complete |
| AWS immutable evidence vault | Complete |
| Evidence capture script | Complete |
| Machine-readable evidence artifacts | Complete |
| GitHub portfolio structure | In progress |

## Next Steps

Future labs will continue expanding this capstone repository with additional compliance engineering capabilities, including policy validation, CI-based evidence workflows, signing, automated control checks, and OSCAL-aligned evidence references.

The long-term goal of this repository is to demonstrate a complete GRC Engineering workflow where compliant infrastructure is deployed through code, validated automatically, and supported by durable evidence artifacts.
