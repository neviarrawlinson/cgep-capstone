# GCP Security Services Baseline



This Terraform baseline deploys the Lab 5.4 GCP security services baseline.



## Services and Controls

| Area | Implementation | Control Intent |

|---|---|---|

| Org Policy | Enforces uniform bucket-level access, disables service account key creation, and requires OS Login | Prevents non-compliant configuration at the API layer |

| Workload Identity Federation | Allows GitHub Actions to authenticate without long-lived service account keys | Replaces static credentials with short-lived OIDC-based access |

| Data Access Audit Logs | Enables ADMIN_READ, DATA_READ, and DATA_WRITE logs for Storage, KMS, and IAM | Captures access evidence for sensitive cloud services |



## Evidence



Evidence for this lab is captured in:



evidence/lab-5-4/



## Cost Note



Org Policy and Workload Identity Federation are free. Data Access logs can generate Cloud Logging ingestion and storage costs, especially in active projects.



