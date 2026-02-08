# - Naming conventions
# - Tags
# - Reusable strings
# - JSON fragments
# This is where you enforce elegance and consistency.

locals {
  # Standard naming convention
  name_prefix = "${var.project}-${var.environment}-${var.service_name}"

  # Common tags applied to all resources
  common_tags = {
    Project     = var.project
    Environment = var.environment
    Service     = var.service_name
    ManagedBy   = "Terraform"
  }
}
