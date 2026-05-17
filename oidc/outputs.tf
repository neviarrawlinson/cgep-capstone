output "role_arn" {
  value       = aws_iam_role.grc_gate.arn
  description = "IAM role ARN used by GitHub Actions through OIDC."
}

output "oidc_provider_arn" {
  value       = aws_iam_openid_connect_provider.github.arn
  description = "GitHub Actions OIDC provider ARN."
}
