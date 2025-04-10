data "azurerm_client_config" "current" {}
data "azuread_client_config" "current" {}

# Configure the SOPS Provider
data "sops_file" "secret_variables" {
  source_file = "../../../../sops/secrets.${var.env}.yaml"
}
