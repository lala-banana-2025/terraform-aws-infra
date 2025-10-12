# ==============================================
# Example dev variables (placeholders)
# ----------------------------------------------
# Your current vpc.tf/basec2.tf hard-code these values.
# Keep them here to make future refactors easy.
# If not referenced by variables, Terraform will ignore them.
# ==============================================
aws_region           = "ap-northeast-1"
vpc_cidr             = "10.10.0.0/16"
public_subnet_cidr   = "10.10.10.0/24"
az1                  = "ap-northeast-1a"
instance_type        = "t2.micro"
key_name             = "infra-lala"
allow_ssh_cidrs      = ["0.0.0.0/0"]
allow_http_cidrs     = ["0.0.0.0/0"]
