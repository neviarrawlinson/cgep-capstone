# CGE-P Capstone Portfolio

This repository contains hands-on lab work, infrastructure-as-code artifacts, and machine-readable evidence created as part of the GRC Engineering Academy CGE-P certification.

The purpose of this portfolio is to demonstrate practical GRC Engineering skills by translating compliance requirements into technical controls, deploying secure cloud resources with Terraform, and generating audit-ready evidence without relying on manual screenshots.

## Overview

This capstone repository focuses on the intersection of:

- Governance, Risk, and Compliance Engineering
- Infrastructure as Code
- Cloud security control implementation
- Machine-readable compliance evidence
- Audit-ready technical documentation

Each lab is structured to show not only what was built, but how the implemented controls align to compliance objectives and how evidence can be captured in a repeatable way.

## Repository Structure

```text
cgep-capstone/
├── evidence/
│   └── lab-2-3/
│       ├── plan.json
│       └── state.json
├── terraform/
│   └── primitives/
│       └── compliant-s3/
│           ├── main.tf
│           ├── variables.tf
│           ├── outputs.tf
│           └── README.md
├── .gitignore
└── README.md
```
Completed Labs
Lab 2.3: Building Your First Compliant Resource

This lab builds a compliant AWS S3 storage primitive using Terraform. The module creates a primary S3 bucket and a dedicated log bucket with baseline security and compliance controls enforced through code.

The implementation includes encryption, versioning, public access restrictions, access logging, and required compliance tags. Evidence is captured through Terraform-generated JSON outputs instead of screenshots.

Control Implementation Summary
Control	Control Objective	Technical Implementation
SC-28	Protect information at rest	Enables AES-256 server-side encryption on the primary S3 bucket
AU-3	Generate audit records	Enables S3 server access logging to a dedicated log bucket
AU-6	Support audit review and analysis	Captures Terraform plan and state output as machine-readable evidence
CM-6	Enforce configuration settings	Applies required compliance tags and enables versioning
AC-3	Enforce access control	Blocks all public access paths using S3 public access block settings
Evidence Artifacts

The following evidence files were generated for Lab 2.3:

evidence/lab-2-3/plan.json
evidence/lab-2-3/state.json

These files provide machine-readable evidence of the planned and deployed infrastructure configuration.

The evidence demonstrates:

Encryption configuration
Versioning status
Public access block settings
Logging configuration
Compliance tags
Terraform-managed resource state
Terraform Primitive

The compliant S3 primitive is located at:

terraform/primitives/compliant-s3/

The module includes:

File	Purpose
main.tf	Defines AWS provider settings, S3 buckets, encryption, logging, versioning, and access controls
variables.tf	Defines validated input variables for project name, environment, and bucket suffix
outputs.tf	Exposes bucket identifiers and encryption evidence
README.md	Documents the purpose and control alignment of the S3 primitive
Tools and Technologies

This lab uses:

Terraform
AWS CLI
AWS S3
PowerShell
Git
GitHub
Skills Demonstrated

This repository demonstrates the ability to:

Convert compliance requirements into technical cloud controls
Deploy compliant infrastructure using Terraform
Generate audit-ready evidence in JSON format
Structure evidence artifacts for repeatable review
Align cloud configuration to control objectives
Maintain a clean GitHub portfolio repository
Avoid committing sensitive Terraform state, local variables, or credentials
Security Notes

Sensitive local files are intentionally excluded from version control through .gitignore, including:

.terraform/
*.tfstate
*.tfstate.*
tfplan
terraform.tfvars
*.backup
.aws/
*.pem
*.key

This helps prevent accidental exposure of local state, credentials, keys, or environment-specific configuration.

Portfolio Purpose

This repository is part of my broader GRC Engineering portfolio. It is designed to show practical experience with building compliant systems, automating evidence collection, and using engineering practices to support governance, risk, and compliance outcomes.

Rather than treating compliance as a manual documentation exercise, this project demonstrates how compliance expectations can be embedded directly into technical workflows, infrastructure code, and evidence generation processes.

Current Status

Lab	Status
Lab 2.3: Building Your First Compliant Resource	Complete

Next Steps

Future labs will continue expanding this repository with additional compliant primitives, automated policy validation, evidence workflows, and control mapping artifacts.
