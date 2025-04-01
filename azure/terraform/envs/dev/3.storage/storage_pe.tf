###################
# Create private endpoint for storage contents
###################
module "storage_contents_private_endpoint" {
  source = "git@github.com:framgia/sun-infra-iac.git//modules/private-endpoint?ref=terraform-azure-private-endpoint_v0.0.1"

  #basic
  env                 = var.env
  project             = var.project
  location            = var.location
  resource_group_name = data.terraform_remote_state.general.outputs.resource_group_name

  #private_endpoint
  private_enpoint = {
    name      = var.storage.content.container.name
    subnet_id = data.terraform_remote_state.general.outputs.subnet_storage_id
    private_service_connection = {
      is_manual_connection           = false
      private_connection_resource_id = module.storage_contents.storage_account_id
      subresource_names              = ["blob"]
    }
    private_dns_zone_group = {
      name                 = "default"
      private_dns_zone_ids = [module.storage_contents_private_dns_zone.private_dns_id]
    }
  }

  tags = local.default_tags
}
