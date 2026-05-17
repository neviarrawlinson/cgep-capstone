# OSCAL Artifacts

This folder contains OSCAL artifacts for the CGE-P capstone portfolio.

## Component Definitions

| Component | Location | Purpose |
|---|---|---|
| compliant-s3 v1 | component-definitions/compliant-s3-v1/component-definition.json | Describes how the Terraform compliant-s3 primitive implements selected NIST SP 800-53 Rev 5 controls |

## Profiles

| Profile | Location | Purpose |
|---|---|---|
| CGE-P minimum control selection | profiles/cge-p-minimum/profile.json | Selects SC-28, AC-3, AU-3, and CM-6 from the NIST SP 800-53 Rev 5 catalog |

## Resolved Catalog

| Resolved Catalog | Location | Purpose |
|---|---|---|
| CGE-P minimum resolved catalog | catalogs/cge-p-minimum-resolved/catalog.json | Resolves the selected NIST SP 800-53 Rev 5 controls into a standalone OSCAL catalog |

## Evidence Chain

The component definition links implemented requirements to signed evidence in the S3 evidence vault.

The evidence chain can be verified with:

```bash
bash scripts/verify-evidence.sh <run_id> --vault <vault_name> --profile cgep-sandbox
```

The current component evidence points to the signed evidence bundle recorded in:

```text
evidence/lab-5-4/chain-receipt.json
```
