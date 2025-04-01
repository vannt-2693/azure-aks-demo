data "azurerm_client_config" "current" {}
data "azuread_client_config" "current" {}

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
