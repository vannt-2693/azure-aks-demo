# Configure the Microsoft Azure Provider
# Use Environment Variables for service_principal_client_certificate config
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/guides/service_principal_client_certificate
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/guides/service_principal_client_secret
provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
}

# Configure the SOPS Provider
provider "sops" {}

provider "kubernetes" {
  host                   = module.aks_cluster.aks_cluster_kube_config[0].host
  username               = module.aks_cluster.aks_cluster_kube_config[0].username
  password               = module.aks_cluster.aks_cluster_kube_config[0].password
  client_certificate     = base64decode(module.aks_cluster.aks_cluster_kube_config[0].client_certificate)
  client_key             = base64decode(module.aks_cluster.aks_cluster_kube_config[0].client_key)
  cluster_ca_certificate = base64decode(module.aks_cluster.aks_cluster_kube_config[0].cluster_ca_certificate)
}

provider "helm" {
  kubernetes {
    host                   = module.aks_cluster.aks_cluster_kube_config[0].host
    token                  = module.aks_cluster.aks_cluster_kube_config[0].password
    cluster_ca_certificate = base64decode(module.aks_cluster.aks_cluster_kube_config[0].cluster_ca_certificate)
  }
}
