provider "oci" {}

module "baseline" {
  source = "../.."

  tenancy_id            = var.tenancy_id
  parent_compartment_id = var.tenancy_id
  compartment_name      = "example-lz"
  tag_namespace_name    = "example-governance"

  budget_amount           = 250
  budget_alert_threshold  = 80
  budget_alert_recipients = "finops@example.com"

  freeform_tags = {
    Environment = "sandbox"
    ManagedBy   = "terraform"
  }
}

variable "tenancy_id" {
  description = "Tenancy OCID the example baseline is created under."
  type        = string
}

output "compartment_id" {
  value = module.baseline.compartment_id
}
