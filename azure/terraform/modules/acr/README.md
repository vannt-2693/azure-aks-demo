# acr

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.9 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 4.23.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 4.23.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_container_registry.acr](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_registry) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_acr"></a> [acr](#input\_acr) | All configuration to Provides an Azure Container Registry Repository. | <pre>object({<br>    name          = string<br>    sku           = optional(string, "Basic")<br>    admin_enabled = optional(bool, false)<br>    georeplications = optional(list(object({<br>      location                  = string<br>      regional_endpoint_enabled = optional(bool, null)<br>      zone_redundancy_enabled   = optional(bool, false)<br>    })), [])<br>    network_rule_set = optional(object({<br>      default_action = optional(string, "Allow")<br>      ip_rules = optional(list(object({<br>        action   = string<br>        ip_range = string<br>      })), [])<br>      virtual_network_subnet_id = optional(string, null)<br>    }), null)<br>    public_network_access_enabled = optional(bool, true)<br>    quarantine_policy_enabled     = optional(bool, null)<br>    retention_policy_in_days      = optional(number, null)<br>    trust_policy_enabled          = optional(bool, false)<br>    zone_redundancy_enabled       = optional(bool, false)<br>    export_policy_enabled         = optional(bool, true)<br>    anonymous_pull_enabled        = optional(bool, null)<br>    data_endpoint_enabled         = optional(bool, null)<br>    network_rule_bypass_option    = optional(string, "AzureServices")<br>    identity = optional(object({<br>      type         = string<br>      identity_ids = optional(list(string), [])<br>    }), null)<br>    encryption = optional(object({<br>      key_vault_key_id   = string<br>      identity_client_id = string<br>    }), null)<br>  })</pre> | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | Location of environment | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Name of resource group | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) Common tags | `map(string)` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_acr_admin_password"></a> [acr\_admin\_password](#output\_acr\_admin\_password) | The Password associated with the Container Registry Admin account - if the admin account is enabled. |
| <a name="output_acr_admin_username"></a> [acr\_admin\_username](#output\_acr\_admin\_username) | The Username associated with the Container Registry Admin account - if the admin account is enabled. |
| <a name="output_acr_id"></a> [acr\_id](#output\_acr\_id) | The ID of the Container Registry. |
| <a name="output_acr_login_server"></a> [acr\_login\_server](#output\_acr\_login\_server) | The URL that can be used to log into the container registry. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
