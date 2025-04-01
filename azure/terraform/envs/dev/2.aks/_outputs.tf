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
output "configure_kubectl" {
  description = "Configure kubectl: make sure you're logged in with the correct Azure account and run the following command to update your kubeconfig"
  value       = "az aks get-credentials --resource-group ${data.terraform_remote_state.general.outputs.resource_group_name} --name ${module.aks_cluster.aks_cluster_name}"
}
