###################
# Key vault secrets
###################
module "secrets" {
  source = "git@github.com:framgia/sun-infra-iac.git//modules/key-vault?ref=terraform-azure-key-vault_v0.0.1"

  #basic
  env                 = var.env
  project             = var.project
  location            = var.location
  resource_group_name = module.resource_group.resource_group_name

  #key_vault
  key_vault = {
    name      = "${var.project}-${var.env}-secrets"
    sku_name  = "standard"
    tenant_id = data.azurerm_client_config.current.tenant_id
  }

  #access policies
  key_vault_access_policy = {
    object_id          = data.azurerm_client_config.current.object_id
    application_id     = data.azurerm_client_config.current.client_id
    key_permissions    = ["Create", "Delete", "Get", "List", "Encrypt", "Decrypt"]
    secret_permissions = ["Get", "List", "Set", "Delete"]
  }

  #secrets
  key_vault_secrets = [
    {
      name  = "storage-conn-string"
      value = data.sops_file.secret_variables.data["aks_storage_conn_string"]
    }
  ]

  tags = local.default_tags
}
