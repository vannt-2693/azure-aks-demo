###################
# Create private DNS for storage contents
###################
module "storage_contents_private_dns_zone" {
  source = "git@github.com:framgia/sun-infra-iac.git//modules/private-dns-zone?ref=terraform-azure-private-dns-zone_v0.0.1"

  #basic
  env                 = var.env
  project             = var.project
  resource_group_name = data.terraform_remote_state.general.outputs.resource_group_name

  #redis_private_dns_zone
  private_dns_zone = {
    name = "privatelink.blob.core.windows.net"
  }

  #virtual_network_link
  private_dns_zone_virtual_network_link = {
    name               = "storage"
    virtual_network_id = data.terraform_remote_state.general.outputs.vnet_id
  }

  tags = local.default_tags
}
