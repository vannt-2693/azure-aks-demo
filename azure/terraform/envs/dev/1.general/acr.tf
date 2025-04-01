###################
# Azure Container Registry
###################
module "acr_api" {
  source = "../../../modules/acr"

  #basic
  location            = var.location
  resource_group_name = module.resource_group.resource_group_name

  #acr
  acr = {
    name          = replace(lower("${var.project}${var.env}apiacr"), "-", "")
    admin_enabled = true
    sku           = "Basic"
  }

  tags = local.default_tags
}
