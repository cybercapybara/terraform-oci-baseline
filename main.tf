resource "oci_identity_compartment" "this" {
  compartment_id = var.parent_compartment_id
  name           = var.compartment_name
  description    = var.compartment_description
  enable_delete  = true

  freeform_tags = var.freeform_tags
  defined_tags  = var.defined_tags
}

resource "oci_identity_tag_namespace" "this" {
  compartment_id = var.tenancy_id
  name           = var.tag_namespace_name
  description    = "Governance tag namespace for the ${var.compartment_name} baseline"

  freeform_tags = var.freeform_tags
  defined_tags  = var.defined_tags
}

resource "oci_identity_tag" "this" {
  for_each = toset(var.tag_keys)

  tag_namespace_id = oci_identity_tag_namespace.this.id
  name             = each.value
  description      = "Governance tag ${each.value}"

  freeform_tags = var.freeform_tags
}

resource "oci_budget_budget" "this" {
  compartment_id = var.tenancy_id
  display_name   = "${var.compartment_name}-budget"
  description    = "Monthly budget for the ${var.compartment_name} baseline compartment"

  target_type = "COMPARTMENT"
  targets     = [oci_identity_compartment.this.id]

  amount       = var.budget_amount
  reset_period = "MONTHLY"

  freeform_tags = var.freeform_tags
  defined_tags  = var.defined_tags
}

resource "oci_budget_alert_rule" "this" {
  budget_id      = oci_budget_budget.this.id
  type           = "ACTUAL"
  threshold      = var.budget_alert_threshold
  threshold_type = "PERCENTAGE"
  recipients     = var.budget_alert_recipients
  message        = "The ${var.compartment_name} baseline compartment has reached ${var.budget_alert_threshold}% of its monthly budget."
}
