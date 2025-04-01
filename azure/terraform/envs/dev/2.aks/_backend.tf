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
    azuread = {
      source  = "hashicorp/azuread"
      version = "= 2.53.1"
    }
    sops = {
      source  = "carlpett/sops"
      version = ">= 0.7.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.23.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = ">= 2.10.1"
    }
  }

  backend "azurerm" {
    resource_group_name  = "project-dev-iac-rg"
    storage_account_name = "projectdeviacstates"
    container_name       = "iacstates"
    key                  = "2.web/terraform.dev.tfstate"
  }
}
