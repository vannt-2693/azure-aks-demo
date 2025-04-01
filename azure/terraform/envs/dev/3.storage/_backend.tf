###################
# General Initialization
###################
terraform {
  required_version = ">= 1.3.9"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "= 4.23.0"
    }
    # azuread = {
    #   source  = "hashicorp/azuread"
    #   version = "= 2.53.1"
    # }
  }

  backend "azurerm" {
    resource_group_name  = "project-dev-iac-rg"
    storage_account_name = "projectdeviacstates"
    container_name       = "iacstates"
    key                  = "3.storage/terraform.dev.tfstate"
  }
}
