data "azurerm_client_config" "current" {}
data "azuread_client_config" "current" {}

# Configure the SOPS Provider
data "sops_file" "secret_variables" {
  source_file = "../../../../sops/secrets.${var.env}.yaml"
}

###################
# General State
###################
data "terraform_remote_state" "general" {
  backend = "azurerm"
  config = {
    resource_group_name  = "project-dev-iac-rg"
    storage_account_name = "projectdeviacstates"
    container_name       = "iacstates"
    key                  = "1.general/terraform.${var.env}.tfstate"
  }
}
