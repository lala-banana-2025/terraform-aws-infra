# ==============================================
# Terraform core version constraints
# ----------------------------------------------
# Keep ONLY the required_version here to avoid the
# "Duplicate required providers configuration" error.
# Your vpc.tf already has required_providers for aws.
# ==============================================
terraform {
  required_version = ">= 1.5.0, < 2.0.0"
}
