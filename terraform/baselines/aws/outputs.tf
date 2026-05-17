output "cloudtrail_name" {
  value       = aws_cloudtrail.mgmt.name
  description = "Name of the multi-region CloudTrail trail."
}

output "cloudtrail_bucket" {
  value       = aws_s3_bucket.trail.bucket
  description = "S3 bucket storing CloudTrail logs."
}

output "securityhub_enabled" {
  value       = true
  description = "Indicates that Security Hub is managed by this baseline."
}

output "enabled_standards" {
  value = [
    aws_securityhub_standards_subscription.nist_800_53.standards_arn,
    aws_securityhub_standards_subscription.fsbp.standards_arn
  ]
  description = "Security Hub standards enabled by this baseline."
}
