# Compliant GCS Primitive

This Terraform consumer deploys the `compliant-gcs-bucket` module for the dev environment.

## Purpose

This primitive demonstrates how a reusable Terraform module can enforce a compliance baseline while allowing consumers to provide only business-specific inputs such as project ID, environment, retention period, and bucket naming suffix.

## Environment

| Field | Value |
|---|---|
| GCP Project | cge-p-sandbox |
| Environment | dev |
| Retention Period | 30 days |
| Region | us-central1 |
| Bucket Suffix | dev-data-nr001 |

## Module Used

terraform/modules/compliant-gcs-bucket

## Evidence

This primitive produces a `compliance_attestation` output that confirms the module-enforced controls for encryption, versioning, public access prevention, uniform access, retention, labels, and KMS key rotation.
