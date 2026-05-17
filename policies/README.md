\# Compliance Policy Library



This directory contains Rego policies for evaluating Terraform plan JSON before infrastructure is applied.



\## Purpose



The policy library supports policy-as-code validation across cloud providers. The policies map technical infrastructure checks to NIST 800-53 control IDs and produce developer-readable deny messages with the control, resource, violation, and remediation guidance.



\## Policies



| Policy | Cloud | Control | Severity | Purpose | Remediation |

|---|---|---|---|---|---|

| sc28\_encryption.rego | GCP | SC-28 | High | Requires Google Cloud Storage buckets to use customer-managed encryption keys | Add an encryption block with default\_kms\_key\_name |

| ac3\_no\_public.rego | GCP | AC-3 | Critical | Prevents public GCS bucket access and public management-port firewall exposure | Enforce uniform bucket-level access, public access prevention, and narrow firewall source ranges |

| cm6\_required\_tags.rego | GCP | CM-6 | Medium | Requires standard compliance labels on taggable GCP resources | Add project, environment, managed\_by, and compliance\_scope labels |

| sc28\_encryption\_aws.rego | AWS | SC-28 | High | Requires every S3 bucket to have a matching server-side encryption configuration | Add aws\_s3\_bucket\_server\_side\_encryption\_configuration for the bucket |

| ac3\_no\_public\_aws.rego | AWS | AC-3 | Critical | Requires every S3 bucket to have a complete public access block configuration | Add aws\_s3\_bucket\_public\_access\_block with all four flags set to true |

| cm6\_required\_tags\_aws.rego | AWS | CM-6 | Medium | Requires standard compliance tags on taggable AWS resources | Add Project, Environment, ManagedBy, and ComplianceScope tags or use provider default\_tags |



\## Evidence



Lab 3.3 OPA test evidence:



```text

evidence/lab-3-3/opa-test-results.json

