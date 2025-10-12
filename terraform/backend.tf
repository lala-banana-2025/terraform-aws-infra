# ==============================================
# Backend configuration (injected by CI)
# ----------------------------------------------
# Leave this file empty or commented. In CI we run:
#   terraform init -backend-config="bucket=..."
#                  -backend-config="key=..."
#                  -backend-config="region=..."
#                  -backend-config="dynamodb_table=..."
# If you really want to pin the backend in code, you could later add:
#
# terraform {
#   backend "s3" {}
# }
#
# but the recommended approach for pipelines is to inject via init.
# ==============================================
