# CGE-P Capstone Portfolio

This repository contains hands-on labs and evidence artifacts completed for the GRC Engineering Academy CGE-P certification.

The goal of this capstone repository is to demonstrate practical Governance, Risk, and Compliance Engineering skills through infrastructure-as-code, machine-readable evidence, and compliance-aligned cloud security primitives.

## Repository Structure

```text
cgep-capstone/
+-- evidence/
¦   +-- lab-2-3/
¦       +-- plan.json
¦       +-- state.json
+-- terraform/
    +-- primitives/
        +-- compliant-s3/
            +-- main.tf
            +-- variables.tf
            +-- outputs.tf
            +-- README.md
Completed Labs
Lab 2.3: Building Your First Compliant Resource

This lab builds a compliant AWS S3 primitive using Terraform. The module creates a primary S3 bucket and a dedicated log bucket with security and compliance controls applied by code.

Implemented controls include:

ControlImplementation
SC-28AES-256 server-side encryption for data at rest
AU-3S3 server access logging to a dedicated log bucket
AU-6Machine-readable Terraform evidence for audit review
CM-6Required compliance tags and versioning
AC-3Full S3 public access blocking
Evidence

Evidence is captured as JSON instead of screenshots:

evidence/lab-2-3/plan.json
evidence/lab-2-3/state.json

These files provide machine-readable proof of the planned and deployed compliant infrastructure.

Tools Used
Terraform
AWS CLI
AWS S3
GitHub
PowerShell
Purpose

This repository is part of my broader GRC Engineering portfolio. It demonstrates the ability to translate compliance requirements into enforceable technical controls, generate evidence through automation, and structure artifacts for audit readiness.
