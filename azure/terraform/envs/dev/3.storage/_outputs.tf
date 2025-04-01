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
