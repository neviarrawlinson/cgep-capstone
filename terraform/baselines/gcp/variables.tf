variable "gcp_project" {
  type        = string
  description = "GCP project ID for the security services baseline."
  default     = "cge-p-sandbox"
}

variable "gcp_region" {
  type        = string
  description = "Default GCP region."
  default     = "us-central1"
}

variable "github_repository" {
  type        = string
  description = "GitHub repository allowed to authenticate through Workload Identity Federation."
  default     = "neviarrawlinson/cgep-capstone"
}

variable "service_account_id" {
  type        = string
  description = "Service account ID for the GRC gate service account."
  default     = "cgep-grc-gate-sa"
}
variable "enable_org_policy" {
  type        = bool
  description = "Whether to enforce project-level Org Policies. Requires org-level Org Policy Administrator permissions inherited to the project."
  default     = false
}