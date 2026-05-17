# GitHub Actions AWS OIDC Role

This Terraform module creates the AWS IAM OIDC provider and role used by the Lab 4.3 GRC evidence pipeline.

## Purpose

The role allows GitHub Actions to assume AWS permissions through OIDC without storing long-lived AWS access keys in GitHub.

## Repository Trust Scope

This role is scoped to:

repo:neviarrawlinson/cgep-capstone:*

## Output

The role_arn output is stored as the GitHub repository variable:

AWS_ROLE_ARN
