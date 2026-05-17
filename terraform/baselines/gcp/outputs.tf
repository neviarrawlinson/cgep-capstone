output "gcp_project" {
  value       = var.gcp_project
  description = "GCP project ID."
}

output "gcp_project_number" {
  value       = data.google_project.current.number
  description = "GCP project number."
}

output "workload_identity_pool_name" {
  value       = google_iam_workload_identity_pool.github.name
  description = "Full Workload Identity Pool resource name."
}

output "workload_identity_provider_name" {
  value       = google_iam_workload_identity_pool_provider.github.name
  description = "Full Workload Identity Provider resource name."
}

output "service_account_email" {
  value       = google_service_account.grc_gate.email
  description = "Service account email used by GitHub Actions."
}

output "github_repository_condition" {
  value       = var.github_repository
  description = "GitHub repository allowed by the WIF provider attribute condition."
}

output "org_policies_enforced" {
  value = var.enable_org_policy ? [
    google_org_policy_policy.uniform_bucket_access[0].name,
    google_org_policy_policy.disable_service_account_keys[0].name,
    google_org_policy_policy.require_os_login[0].name
  ] : []

  description = "Project-level Org Policies enforced by this baseline when enable_org_policy is true."
}

output "org_policy_status" {
  value       = var.enable_org_policy ? "enabled" : "not_applied_permission_limited"
  description = "Org Policy deployment status for this baseline."
}

output "audit_log_services" {
  value = [
    google_project_iam_audit_config.storage.service,
    google_project_iam_audit_config.kms.service,
    google_project_iam_audit_config.iam.service
  ]
  description = "Services with Data Access audit logs enabled."
}
