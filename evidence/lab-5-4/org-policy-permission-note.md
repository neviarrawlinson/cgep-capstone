# Lab 5.4 Org Policy Permission Note

The GCP Security Services baseline successfully deployed Workload Identity Federation, the GitHub OIDC provider, the GRC gate service account, the Workload Identity User binding, the project viewer binding, and Data Access audit logging for Storage, KMS, and IAM.

The three project-level Org Policy resources were not applied because the active user does not have the required orgpolicy.policies.create permission on the project.

Terraform returned:

Permission 'orgpolicy.policies.create' denied on resource '//cloudresourcemanager.googleapis.com/projects/cge-p-sandbox'

An attempt to grant roles/orgpolicy.policyAdmin at the project level also failed because the role is not supported for this resource. Org Policy Administrator must be granted at the organization level and inherited by the project.

For this lab portfolio, Org Policy enforcement is documented as permission-limited, while WIF and Data Access audit logging are implemented and captured as evidence.
