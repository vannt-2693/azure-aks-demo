output "azure_account_info" {
  value = <<EOT
  Check Azure Env:
    Project : "${var.project}" | Env: "${var.env}"
    Azure Subscription ID: "${data.azurerm_client_config.current.subscription_id}"
    Azure Client ID: "${data.azurerm_client_config.current.client_id}"
    Azure Tenant ID: "${data.azurerm_client_config.current.tenant_id}"
  EOT

  description = "Show information about project, environment, and account"
}

#Output modules
output "resource_group_name" {
  value       = module.resource_group.resource_group_name
  description = "Name of resource group"
}
output "vnet_id" {
  value       = module.vnet.vnet_id
  description = "ID of VNET"
}
output "acr_api_id" {
  value       = module.acr_api.acr_id
  description = "ID of ACR"
}
output "subnet_aks_id" {
  value       = module.vnet.subnet_id["aks"]
  description = "ID of subnet AKS"
}
output "subnet_agw_id" {
  value       = module.vnet.subnet_id["agw"]
  description = "ID of subnet Application Gateway"
}
output "subnet_storage_id" {
  value       = module.vnet.subnet_id["storage"]
  description = "ID of subnet Storage"
}
output "nat_gw_public_ip" {
  value       = module.vnet.nat_gateway_ips["natgw"].public_ip
  description = "The Public IP of the NAT Gateway AKS."
}
