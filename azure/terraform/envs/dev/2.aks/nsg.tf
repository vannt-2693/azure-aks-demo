###################
# Network security group ingress controller only allow traffic from Application Gateway and deny all other traffic
###################
module "nsg_ingress_controller" {
  source = "git@github.com:framgia/sun-infra-iac.git//modules/nsg?ref=terraform-azure-nsg_v0.0.1"

  #basic
  env                 = var.env
  project             = var.project
  location            = var.location
  resource_group_name = data.terraform_remote_state.general.outputs.resource_group_name

  #nsg
  name = "ingress-controller"
  security_rules = [
    {
      name                       = "Allow-AppGW-To-Ingress"
      priority                   = 100
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "*"
      source_port_range          = "*"
      destination_port_ranges    = ["80", "443"]
      source_address_prefix      = "${azurerm_public_ip.agw_ip.ip_address}/32"
      destination_address_prefix = "*"
    },
    {
      name                       = "Allow-Healthz-AppGW"
      priority                   = 150
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "*"
      source_port_range          = "*"
      destination_port_ranges    = ["80", "443"]
      source_address_prefix      = var.vnet.subnet_configuration["agw"].cidr
      destination_address_prefix = "*"
    },
    {
      name                       = "Deny-Other-Ingress"
      priority                   = 200
      direction                  = "Inbound"
      access                     = "Deny"
      protocol                   = "*"
      source_port_range          = "*"
      destination_port_ranges    = ["80", "443"]
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    }
  ]

  #subnet association
  nsg_association = {
    subnet_id = data.terraform_remote_state.general.outputs.subnet_aks_id
  }

  tags = local.default_tags
}
