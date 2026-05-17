\# Compliance Policy Library



This directory contains Rego policies for evaluating Terraform plan JSON before infrastructure is applied.



\## Purpose



The policy library supports Lab 3.3 by validating Terraform plan output before deployment. The goal is to catch compliance issues early by evaluating infrastructure-as-code against control-aligned Rego policies.



\## Policies



| Policy | Control | Severity | Purpose | Remediation |

|---|---|---|---|---|

| sc28\_encryption.rego | SC-28 | High | Requires Google Cloud Storage buckets to use customer-managed encryption keys | Add an encryption block with default\_kms\_key\_name |

| ac3\_no\_public.rego | AC-3 | Critical | Prevents public GCS bucket access and public management-port firewall exposure | Enforce uniform bucket-level access, public access prevention, and narrow firewall source ranges |

| cm6\_required\_tags.rego | CM-6 | Medium | Requires standard compliance labels on taggable resources | Add project, environment, managed\_by, and compliance\_scope labels |



\## Evidence



Test results are stored in:



evidence/lab-3-3/opa-test-results.json



\## Usage



Run all policy tests:



opa test -v policies/



Evaluate policies against the Terraform plan:



opa eval -d policies -i terraform/lab-3-3/plan.json "data.compliance.sc28.deny" --format=pretty



opa eval -d policies -i terraform/lab-3-3/plan.json "data.compliance.ac3.deny" --format=pretty



opa eval -d policies -i terraform/lab-3-3/plan.json "data.compliance.cm6.deny" --format=pretty



\## Controls Covered



| Control | Description |

|---|---|

| SC-28 | Protection of information at rest |

| AC-3 | Access enforcement |

| CM-6 | Configuration settings |



\## Notes



These policies are written for Terraform plan JSON. They evaluate planned infrastructure before deployment and return developer-readable deny messages that include the control ID, resource address, and remediation guidance.

