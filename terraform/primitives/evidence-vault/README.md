# Evidence Vault Primitive

This Terraform primitive creates an AWS S3 evidence vault for CGE-P Lab 2.5.

## Purpose

The vault stores compliance evidence bundles using S3 Object Lock, versioning, encryption, and public access blocking.

## Controls and Evidence Properties

| Evidence Property | Implementation |
|---|---|
| Integrity | Evidence files are hashed with SHA-256 before bundling |
| Attribution | Commit metadata is captured in the evidence bundle |
| Reproducibility | Terraform plan, state, version, and commit metadata are bundled together |
| Immutability | S3 Object Lock applies default retention to uploaded evidence |
| Durability | S3 VersionId is recorded in the receipt |

## Lab Defaults

| Setting | Value |
|---|---|
| Object Lock Mode | GOVERNANCE |
| Retention | 1 day |
| Encryption | AES-256 |
| Versioning | Enabled |
| Public Access | Blocked |

GOVERNANCE mode is used for lab work so the test evidence can be cleaned up later.
