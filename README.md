# terraform-oci-baseline

Terraform module that provisions a small [Oracle Cloud Infrastructure](https://www.oracle.com/cloud/)
landing-zone baseline: a dedicated compartment, a governance defined-tag namespace with a
set of standard tag keys, and a monthly budget with a threshold alert scoped to the new
compartment. Use it as the first step when onboarding a new team or environment.

## Usage

```hcl
module "baseline" {
  source = "github.com/cybercapybara/terraform-oci-baseline"

  tenancy_id            = var.tenancy_id
  parent_compartment_id = var.tenancy_id
  compartment_name      = "team-alpha"
  tag_namespace_name    = "alpha-governance"

  budget_amount           = 1000
  budget_alert_threshold  = 90
  budget_alert_recipients = "finops@example.com"

  freeform_tags = {
    Environment = "production"
    ManagedBy   = "terraform"
  }
}
```

A runnable example lives in [`examples/basic`](examples/basic).

## Requirements

| Name      | Version  |
|-----------|----------|
| terraform | >= 1.5   |
| oci       | >= 5.0   |

## Inputs

| Name                      | Description                                                        | Type           | Default                            | Required |
|---------------------------|--------------------------------------------------------------------|----------------|------------------------------------|:--------:|
| `tenancy_id`              | OCID of the tenancy the baseline is created under.                 | `string`       | n/a                                |   yes    |
| `parent_compartment_id`   | OCID of the parent compartment for the new compartment.            | `string`       | n/a                                |   yes    |
| `compartment_name`        | Name of the landing-zone compartment.                             | `string`       | n/a                                |   yes    |
| `compartment_description` | Description of the landing-zone compartment.                       | `string`       | landing-zone default               |    no    |
| `tag_namespace_name`      | Name of the defined-tag namespace.                                | `string`       | n/a                                |   yes    |
| `tag_keys`                | Defined-tag keys to create in the namespace.                      | `list(string)` | `["Environment","Owner","CostCenter"]` |  no  |
| `budget_amount`           | Monthly budget amount tracking the compartment.                   | `number`       | `100`                              |    no    |
| `budget_alert_threshold`  | Budget percentage at which the alert notifies.                    | `number`       | `80`                               |    no    |
| `budget_alert_recipients` | Comma-separated email recipients for the budget alert.            | `string`       | n/a                                |   yes    |
| `freeform_tags`           | Free-form tags applied to the baseline resources.                 | `map(string)`  | `{}`                               |    no    |
| `defined_tags`            | Defined tags applied to the baseline resources.                   | `map(string)`  | `{}`                               |    no    |

## Outputs

| Name                   | Description                              |
|------------------------|------------------------------------------|
| `compartment_id`       | OCID of the landing-zone compartment.    |
| `tag_namespace_id`     | OCID of the governance tag namespace.    |
| `tag_ids`              | Map of tag key name to tag OCID.         |
| `budget_id`            | OCID of the compartment budget.          |
| `budget_alert_rule_id` | OCID of the budget alert rule.           |

## License

[MIT](LICENSE)
