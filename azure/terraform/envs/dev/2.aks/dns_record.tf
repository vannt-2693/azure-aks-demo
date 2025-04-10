###################
# DNS record
###################
module "dns_record" {
  source = "git@github.com:framgia/sun-infra-iac.git//modules/dns-zone?ref=terraform-azure-dns-zone_v0.0.1"

  #basic
  resource_group_name = data.terraform_remote_state.general.outputs.resource_group_name

  #hostzone
  dns_zone_id = var.domain

  #records
  dns_records = [
    # alias
    {
      type               = "A"
      name               = "aks"
      ttl                = 60
      target_resource_id = azurerm_application_gateway.agw.frontend_ip_configuration[0].public_ip_address_id
    },
    {
      type               = "A"
      name               = "app"
      ttl                = 60
      target_resource_id = azurerm_application_gateway.agw.frontend_ip_configuration[0].public_ip_address_id
    }
  ]

  tags = local.default_tags
}
