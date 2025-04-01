#modules/acr/_outputs.tf
#acr
output "acr_id" {
  description = "The ID of the Container Registry."
  value       = azurerm_container_registry.acr.id
}

output "acr_login_server" {
  description = "The URL that can be used to log into the container registry."
  value       = azurerm_container_registry.acr.login_server
}

output "acr_admin_username" {
  description = "The Username associated with the Container Registry Admin account - if the admin account is enabled."
  value       = var.acr.admin_enabled != null ? azurerm_container_registry.acr.admin_username : 0
}

output "acr_admin_password" {
  description = "The Password associated with the Container Registry Admin account - if the admin account is enabled."
  value       = var.acr.admin_enabled != null ? azurerm_container_registry.acr.admin_password : 0
  sensitive   = true
}
