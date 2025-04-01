###################
# Create vnet & subnet
###################
module "vnet" {
  source = "git@github.com:framgia/sun-infra-iac.git//modules/vnet?ref=terraform-azure-vnet_v0.0.2"

  #basic
  env                 = var.env
  project             = var.project
  location            = var.location
  resource_group_name = module.resource_group.resource_group_name

  #vnet-subnet
  vnet_cidr            = var.vnet.vnet_cidr
  subnet_configuration = var.vnet.subnet_configuration

  #nat-gateway
  nat_gateways = [
    {
      name = "natgw"
      subnet_associations = [ # apply subnet before add association
        module.vnet.subnet_id["aks"]
      ]
    }
  ]

  tags = local.default_tags
}
