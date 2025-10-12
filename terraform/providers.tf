# ==============================================
# Provider config (SAFE template)
# ----------------------------------------------
# ⚠️ Your current vpc.tf already defines:
#   - terraform { required_providers { aws ... } }
#   - provider "aws" { region = "ap-northeast-1" }
# To avoid a "Duplicate provider configuration" error, we keep this file
# as a template only. If you later MOVE the provider block out of vpc.tf,
# you can uncomment the block below.
#
# variable "aws_region" {
#   description = "AWS region"
#   type        = string
#   default     = "ap-northeast-1"
# }
#
# provider "aws" {
#   region = var.aws_region
# }
#
# Tip: set AWS credentials via CodeBuild env or IAM role, not in code.
# ==============================================
