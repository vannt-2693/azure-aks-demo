###################
# Create storage for Store Contents
###################
module "storage_contents" {
  source = "git@github.com:framgia/sun-infra-iac.git//modules/storage?ref=terraform-azure-storage_v0.0.1"

  #basic
  location            = var.location
  resource_group_name = data.terraform_remote_state.general.outputs.resource_group_name

  #storage
  storage_account = {
    name                     = var.storage.content.name
    account_replication_type = var.storage.content.blob.account_replication_type
    account_tier             = var.storage.content.blob.account_tier

    #network_rule
    network_rules = {
      default_action             = "Deny"
      bypass                     = ["AzureServices"]
      ip_rules                   = [for ip in var.global_ips.sun_hni_server : replace(ip, "/32", "")]
      virtual_network_subnet_ids = [data.terraform_remote_state.general.outputs.subnet_storage_id]
    }
  }

  #container
  storage_container = [
    {
      name = var.storage.content.container.name
    }
  ]

  tags = local.default_tags
}
