# CGE-P Capstone Portfolio

This repository contains hands-on lab work, infrastructure-as-code artifacts, compliance evidence, policy-as-code controls, and supporting scripts completed as part of the GRC Engineering Academy CGE-P certification.

The purpose of this capstone portfolio is to demonstrate practical GRC Engineering skills by translating compliance requirements into technical controls, deploying secure cloud resources with Terraform, writing policy-as-code rules, and producing machine-readable evidence that can support audit, assurance, and control validation activities.

## Overview

This repository focuses on the intersection of:

- Governance, Risk, and Compliance Engineering
- Infrastructure as Code
- Cloud security control implementation
- Policy as Code
- Compliance as Code
- Evidence automation
- Machine-readable audit artifacts
- Secure evidence storage
- CI-ready policy gates
- Cross-cloud compliance validation

The labs in this repository show how compliance expectations can be embedded directly into cloud infrastructure, Terraform modules, Rego policies, Conftest gates, evidence workflows, and version-controlled technical artifacts.

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
│   ├── lab-2-5/
│   │   └── receipt.json
│   ├── lab-3-3/
│   │   └── opa-test-results.json
│   └── lab-3-4/
│       ├── conftest-pass.json
│       └── conftest-fail.json
├── policies/
│   ├── ac3_no_public.rego
│   ├── ac3_no_public_aws.rego
│   ├── cm6_required_tags.rego
│   ├── cm6_required_tags_aws.rego
│   ├── sc28_encryption.rego
│   ├── sc28_encryption_aws.rego
│   ├── README.md
│   └── tests/
│       ├── ac3_no_public_test.rego
│       ├── cm6_required_tags_test.rego
│       └── sc28_encryption_test.rego
├── scripts/
│   ├── capture-evidence.sh
│   └── policy-gate.sh
├── terraform/
│   ├── lab-3-3/
│   │   ├── main.tf
│   │   └── .terraform.lock.hcl
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

| Lab | Title | Focus Area | Status |
|---|---|---|---|
| Lab 2.3 | Building Your First Compliant Resource, AWS S3 | Compliant Infrastructure as Code | Complete |
| Lab 2.4 | Terraform Modules for Compliance, GCP | Reusable Compliance Modules | Complete |
| Lab 2.5 | IaC as Compliance Evidence, AWS | Immutable Evidence and Chain of Custody | Complete |
| Lab 3.3 | Writing Compliance Policies in Rego, GCP | OPA and Rego Policy as Code | Complete |
| Lab 3.4 | Integrating PaC with Terraform via Conftest, AWS | Conftest Policy Gate | Complete |

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

The `version_id` creates a durable reference to the exact uploaded evidence bundle.

## Lab 3.3: Writing Compliance Policies in Rego, GCP

Lab 3.3 introduces policy-as-code using OPA and Rego. The lab evaluates Terraform plan JSON before infrastructure is applied and returns deny messages when planned resources violate defined compliance expectations.

### Policy Location

```text
policies/
```

### Test Location

```text
policies/tests/
```

### Terraform Fixture

```text
terraform/lab-3-3/
```

### Policies Created

| Policy | Cloud | Control | Purpose |
|---|---|---|---|
| sc28_encryption.rego | GCP | SC-28 | Requires Google Cloud Storage buckets to use customer-managed encryption keys |
| ac3_no_public.rego | GCP | AC-3 | Prevents public GCS bucket access and public management-port firewall exposure |
| cm6_required_tags.rego | GCP | CM-6 | Requires standard compliance labels on taggable GCP resources |

### Policy Test Summary

The policy library includes unit tests for compliant and non-compliant behavior.

```text
OPA tests: 8/8 passed
```

### Evidence Artifact

```text
evidence/lab-3-3/opa-test-results.json
```

This file provides machine-readable OPA test evidence showing that the Rego policy tests passed.

## Lab 3.4: Integrating PaC with Terraform via Conftest, AWS

Lab 3.4 extends the policy library from GCP to AWS and integrates the Rego policies into a Terraform plan workflow using Conftest.

The lab demonstrates an important GRC Engineering lesson: control IDs can be portable across cloud providers, but the resource-specific Rego logic must account for different Terraform resource types. The AWS policies preserve the same control intent while inspecting AWS-specific resources.

### AWS Policies Created

| Policy | Cloud | Control | Purpose |
|---|---|---|---|
| sc28_encryption_aws.rego | AWS | SC-28 | Requires every S3 bucket to have a matching server-side encryption configuration |
| ac3_no_public_aws.rego | AWS | AC-3 | Requires every S3 bucket to have a complete public access block configuration |
| cm6_required_tags_aws.rego | AWS | CM-6 | Requires standard compliance tags on taggable AWS resources |

### Policy Gate Script

```text
scripts/policy-gate.sh
```

The policy gate script runs Conftest against selected namespaces and writes machine-readable results to the Lab 3.4 evidence folder.

The script is designed to support future CI integration by allowing a workflow to fail closed when a Terraform plan violates policy.

### Evidence Artifacts

```text
evidence/lab-3-4/conftest-pass.json
evidence/lab-3-4/conftest-fail.json
```

### Pass Evidence

The passing evidence confirms that the compliant Lab 2.3 AWS S3 plan passed the AWS policy checks.

Validated namespaces:

```text
compliance.sc28_aws
compliance.ac3_aws
compliance.cm6_aws
```

### Fail Evidence

The failing evidence confirms that a deliberately broken AWS S3 plan was blocked by Conftest. The broken plan removed the primary S3 bucket encryption configuration, and Conftest returned the expected SC-28 violation:

```text
[SC-28] aws_s3_bucket.primary: aws_s3_bucket has no matching aws_s3_bucket_server_side_encryption_configuration. Remediation: add one referencing this bucket.
```

This proves the policy gate can detect a control violation before infrastructure is merged or deployed.

## Policy Library Summary

The policy library currently supports both GCP and AWS coverage for core compliance controls.

| Control | GCP Policy | AWS Policy |
|---|---|---|
| SC-28 | sc28_encryption.rego | sc28_encryption_aws.rego |
| AC-3 | ac3_no_public.rego | ac3_no_public_aws.rego |
| CM-6 | cm6_required_tags.rego | cm6_required_tags_aws.rego |

## Evidence Philosophy

This repository demonstrates a shift from manual compliance evidence to automated, machine-readable evidence.

Traditional evidence often depends on screenshots, manual exports, and point-in-time visual proof. This portfolio uses Terraform plans, Terraform state, module outputs, JSON attestations, hashes, object versioning, retention-protected storage, OPA test results, and Conftest gate outputs to create evidence that is more repeatable, verifiable, and resistant to silent modification.

The evidence approach in this repository is based on three principles:

| Principle | Meaning |
|---|---|
| Integrity | Evidence should prove it has not changed unexpectedly |
| Attribution | Evidence should show where it came from and what produced it |
| Reproducibility | Evidence should allow reviewers to understand how the result was generated |
| Enforceability | Evidence should show that controls can block non-compliant changes before deployment |

## Tools and Technologies

This portfolio uses:

- Terraform
- AWS CLI
- Google Cloud CLI
- AWS S3
- AWS S3 Object Lock
- Google Cloud Storage
- Google Cloud KMS
- Open Policy Agent
- Rego
- Conftest
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
- Write Rego policies mapped to compliance controls
- Test policy behavior with compliant and non-compliant fixtures
- Evaluate Terraform plan JSON before deployment
- Extend policy coverage across cloud providers
- Use Conftest as a fail-closed policy gate
- Capture pass and fail evidence for CI and audit workflows
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
| GCP Rego policy library | Complete |
| AWS Rego policy variants | Complete |
| OPA unit tests | Complete |
| Conftest policy gate | Complete |
| Pass and fail policy evidence | Complete |
| Machine-readable evidence artifacts | Complete |
| GitHub portfolio structure | In progress |

## Next Steps

Future labs will continue expanding this capstone repository with additional compliance engineering capabilities, including CI-based policy enforcement, automated control checks, signing, evidence packaging, workflow integration, and OSCAL-aligned evidence references.

The long-term goal of this repository is to demonstrate a complete GRC Engineering workflow where compliant infrastructure is deployed through code, validated automatically, blocked when non-compliant, and supported by durable evidence artifacts.
