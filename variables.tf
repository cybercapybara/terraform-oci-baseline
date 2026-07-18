variable "tenancy_id" {
  description = "OCID of the tenancy the baseline is created under."
  type        = string
}

variable "parent_compartment_id" {
  description = "OCID of the parent compartment (or tenancy) under which the baseline compartment is created."
  type        = string
}

variable "compartment_name" {
  description = "Name of the landing-zone compartment to create."
  type        = string
}

variable "compartment_description" {
  description = "Description of the landing-zone compartment."
  type        = string
  default     = "Landing zone baseline compartment managed by Terraform"
}

variable "tag_namespace_name" {
  description = "Name of the defined-tag namespace created for governance tagging."
  type        = string
}

variable "tag_keys" {
  description = "List of defined-tag keys to create in the namespace."
  type        = list(string)
  default     = ["Environment", "Owner", "CostCenter"]
}

variable "budget_amount" {
  description = "Monthly budget amount, in the tenancy currency, tracking the baseline compartment."
  type        = number
  default     = 100

  validation {
    condition     = var.budget_amount > 0
    error_message = "budget_amount must be greater than zero."
  }
}

variable "budget_alert_threshold" {
  description = "Percentage of the budget at which the alert notifies recipients."
  type        = number
  default     = 80

  validation {
    condition     = var.budget_alert_threshold > 0 && var.budget_alert_threshold <= 100
    error_message = "budget_alert_threshold must be between 1 and 100."
  }
}

variable "budget_alert_recipients" {
  description = "Comma-separated list of email recipients for the budget alert."
  type        = string
}

variable "freeform_tags" {
  description = "Free-form tags applied to the baseline resources."
  type        = map(string)
  default     = {}
}

variable "defined_tags" {
  description = "Defined tags applied to the baseline resources, keyed as \"namespace.key\"."
  type        = map(string)
  default     = {}
}
