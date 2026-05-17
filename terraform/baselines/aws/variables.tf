variable "aws_region" {
  type        = string
  description = "AWS region for the security services baseline."
  default     = "us-east-1"
}

variable "project_name" {
  type        = string
  description = "Short project identifier used for naming and tagging."
  default     = "cgep-lab"
}

variable "environment" {
  type        = string
  description = "Deployment environment."
  default     = "security"
}
