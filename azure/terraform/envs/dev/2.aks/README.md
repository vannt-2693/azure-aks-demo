# 2.aks

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.9 |
| <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) | = 2.53.1 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | = 4.23.0 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | >= 2.10.1 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | >= 2.23.0 |
| <a name="requirement_sops"></a> [sops](#requirement\_sops) | >= 0.7.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azuread"></a> [azuread](#provider\_azuread) | 2.53.1 |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 4.23.0 |
| <a name="provider_helm"></a> [helm](#provider\_helm) | 2.17.0 |
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | 2.36.0 |
| <a name="provider_sops"></a> [sops](#provider\_sops) | 1.2.0 |
| <a name="provider_terraform"></a> [terraform](#provider\_terraform) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_aks_cluster"></a> [aks\_cluster](#module\_aks\_cluster) | git@github.com:framgia/sun-infra-iac.git//modules/aks | terraform-azure-aks_v0.0.1 |
| <a name="module_dns_record"></a> [dns\_record](#module\_dns\_record) | git@github.com:framgia/sun-infra-iac.git//modules/dns-zone | terraform-azure-dns-zone_v0.0.1 |
| <a name="module_nsg_ingress_controller"></a> [nsg\_ingress\_controller](#module\_nsg\_ingress\_controller) | git@github.com:framgia/sun-infra-iac.git//modules/nsg | terraform-azure-nsg_v0.0.1 |

## Resources

| Name | Type |
|------|------|
| [azurerm_application_gateway.agw](https://registry.terraform.io/providers/hashicorp/azurerm/4.23.0/docs/resources/application_gateway) | resource |
| [azurerm_public_ip.agw_ip](https://registry.terraform.io/providers/hashicorp/azurerm/4.23.0/docs/resources/public_ip) | resource |
| [helm_release.cert_manager](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [helm_release.external_secrets](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [helm_release.local_app](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [helm_release.nginx_ingress](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [kubernetes_ingress_v1.agic_to_nginx](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/ingress_v1) | resource |
| [kubernetes_namespace.cert_manager](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace) | resource |
| [kubernetes_namespace.external_secrets](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace) | resource |
| [kubernetes_namespace.ns_app](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace) | resource |
| [azuread_client_config.current](https://registry.terraform.io/providers/hashicorp/azuread/2.53.1/docs/data-sources/client_config) | data source |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/4.23.0/docs/data-sources/client_config) | data source |
| [sops_file.secret_variables](https://registry.terraform.io/providers/carlpett/sops/latest/docs/data-sources/file) | data source |
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
| <a name="output_configure_kubectl"></a> [configure\_kubectl](#output\_configure\_kubectl) | Configure kubectl: make sure you're logged in with the correct Azure account and run the following command to update your kubeconfig |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
