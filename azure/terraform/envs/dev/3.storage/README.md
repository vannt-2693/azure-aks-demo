# 3.storage

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.9 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | = 4.23.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azuread"></a> [azuread](#provider\_azuread) | 3.3.0 |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 4.23.0 |
| <a name="provider_terraform"></a> [terraform](#provider\_terraform) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_storage_contents"></a> [storage\_contents](#module\_storage\_contents) | git@github.com:framgia/sun-infra-iac.git//modules/storage | terraform-azure-storage_v0.0.1 |
| <a name="module_storage_contents_private_dns_zone"></a> [storage\_contents\_private\_dns\_zone](#module\_storage\_contents\_private\_dns\_zone) | git@github.com:framgia/sun-infra-iac.git//modules/private-dns-zone | terraform-azure-private-dns-zone_v0.0.1 |
| <a name="module_storage_contents_private_endpoint"></a> [storage\_contents\_private\_endpoint](#module\_storage\_contents\_private\_endpoint) | git@github.com:framgia/sun-infra-iac.git//modules/private-endpoint | terraform-azure-private-endpoint_v0.0.1 |

## Resources

| Name | Type |
|------|------|
| [azuread_client_config.current](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/client_config) | data source |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/4.23.0/docs/data-sources/client_config) | data source |
| [terraform_remote_state.general](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aks"></a> [aks](#input\_aks) | Kubernetes Cluster for app | `any` | n/a | yes |
| <a name="input_domain"></a> [domain](#input\_domain) | Domain of environment | `string` | n/a | yes |
| <a name="input_env"></a> [env](#input\_env) | Name of project environment | `string` | n/a | yes |
| <a name="input_full_env"></a> [full\_env](#input\_full\_env) | Full name of project environment | `string` | n/a | yes |
| <a name="input_global_ips"></a> [global\_ips](#input\_global\_ips) | Whitelist ip identify | `any` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | Name region of environment | `string` | n/a | yes |
| <a name="input_project"></a> [project](#input\_project) | Name of project | `string` | n/a | yes |
| <a name="input_storage"></a> [storage](#input\_storage) | Storage for app | `any` | n/a | yes |
| <a name="input_subscription_id"></a> [subscription\_id](#input\_subscription\_id) | ID of subscription | `string` | n/a | yes |
| <a name="input_vnet"></a> [vnet](#input\_vnet) | CIDR for vnet | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_azure_account_info"></a> [azure\_account\_info](#output\_azure\_account\_info) | Show information about project, environment, and account |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
