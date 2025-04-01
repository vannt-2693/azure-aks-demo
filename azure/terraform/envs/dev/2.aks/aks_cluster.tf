###################
# Create aks cluster
###################
module "aks_cluster" {
  source = "git@github.com:framgia/sun-infra-iac.git//modules/aks?ref=terraform-azure-aks_v0.0.1"

  #basic
  env                 = var.env
  project             = var.project
  location            = var.location
  resource_group_name = data.terraform_remote_state.general.outputs.resource_group_name

  #aks
  aks = {
    name                      = var.aks.name
    kubernetes_version        = var.aks.version
    dns_prefix                = var.aks.dns_prefix
    automatic_upgrade_channel = null
    api_server_access_profile = {
      authorized_ip_ranges = concat(var.global_ips.sun_hni_server, "${data.terraform_remote_state.general.outputs.nat_gw_public_ip}/32")
    }
    network_profile = {
      network_plugin = var.aks.network_profile.network_plugin
      network_policy = var.aks.network_profile.network_policy
      service_cidr   = var.aks.network_profile.service_cidr
      service_cidrs  = var.aks.network_profile.service_cidrs
      ip_versions    = var.aks.network_profile.ip_versions
      dns_service_ip = var.aks.network_profile.dns_service_ip
      outbound_type  = "userAssignedNATGateway"
    }
    default_node_pool = {
      name           = var.aks.default_node_pool.name
      node_count     = var.aks.default_node_pool.node_count
      vm_size        = var.aks.default_node_pool.vm_size
      vnet_subnet_id = data.terraform_remote_state.general.outputs.subnet_aks_id
      upgrade_settings = {
        max_surge = 20
      }
    }
    ingress_application_gateway = {
      gateway_id = azurerm_application_gateway.agw.id
    }

    identity = {
      type = "UserAssigned"
    }

    #attach acr
    attached_acr_id_maps = [data.terraform_remote_state.general.outputs.acr_api_id]
  }

  #nodepool
  aks_nodepools = [
    {
      name                        = "worker2"
      node_count                  = 1
      max_count                   = 2
      vm_size                     = "standard_a2_v2"
      zones                       = ["1", "2", "3"]
      os_type                     = "Linux"
      mode                        = "User"
      temporary_name_for_rotation = "worker2"
      tags                        = local.default_tags
    },
  ]

  tags = local.default_tags
}
