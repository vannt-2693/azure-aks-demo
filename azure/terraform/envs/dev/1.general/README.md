# 1.general

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.9 |
| <a name="requirement_azapi"></a> [azapi](#requirement\_azapi) | = 1.13.1 |
| <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) | = 2.53.1 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | = 4.23.0 |
| <a name="requirement_template"></a> [template](#requirement\_template) | ~> 2.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azuread"></a> [azuread](#provider\_azuread) | 2.53.1 |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 4.23.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_acr_api"></a> [acr\_api](#module\_acr\_api) | ../../../modules/acr | n/a |
| <a name="module_dns_zone"></a> [dns\_zone](#module\_dns\_zone) | git@github.com:framgia/sun-infra-iac.git//modules/dns-zone | terraform-azure-dns-zone_v0.0.1 |
| <a name="module_resource_group"></a> [resource\_group](#module\_resource\_group) | git@github.com:framgia/sun-infra-iac.git//modules/resource-group | terraform-azure-resource-group_v0.0.3 |
| <a name="module_vnet"></a> [vnet](#module\_vnet) | git@github.com:framgia/sun-infra-iac.git//modules/vnet | terraform-azure-vnet_v0.0.2 |

## Resources

| Name | Type |
|------|------|
| [azuread_client_config.current](https://registry.terraform.io/providers/hashicorp/azuread/2.53.1/docs/data-sources/client_config) | data source |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/4.23.0/docs/data-sources/client_config) | data source |

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
| <a name="output_acr_api_id"></a> [acr\_api\_id](#output\_acr\_api\_id) | ID of ACR |
| <a name="output_azure_account_info"></a> [azure\_account\_info](#output\_azure\_account\_info) | Show information about project, environment, and account |
| <a name="output_nat_gw_public_ip"></a> [nat\_gw\_public\_ip](#output\_nat\_gw\_public\_ip) | The Public IP of the NAT Gateway AKS. |
| <a name="output_resource_group_name"></a> [resource\_group\_name](#output\_resource\_group\_name) | Name of resource group |
| <a name="output_subnet_agw_id"></a> [subnet\_agw\_id](#output\_subnet\_agw\_id) | ID of subnet Application Gateway |
| <a name="output_subnet_aks_id"></a> [subnet\_aks\_id](#output\_subnet\_aks\_id) | ID of subnet AKS |
| <a name="output_subnet_storage_id"></a> [subnet\_storage\_id](#output\_subnet\_storage\_id) | ID of subnet Storage |
| <a name="output_vnet_id"></a> [vnet\_id](#output\_vnet\_id) | ID of VNET |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
