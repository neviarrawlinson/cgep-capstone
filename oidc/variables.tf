variable "aws_region" {
  type        = string
  description = "AWS region used for IAM provider and role setup."
  default     = "us-east-1"
}

variable "github_org" {
  type        = string
  description = "GitHub owner or organization that owns the repository."
}

variable "github_repo" {
  type        = string
  description = "GitHub repository allowed to assume the role."
}

variable "role_name" {
  type        = string
  description = "IAM role name for the GitHub Actions GRC gate."
  default     = "cgep-grc-gate"
}
