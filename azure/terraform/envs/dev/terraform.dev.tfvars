project         = "project"
env             = "dev"
full_env        = "development"
location        = "japaneast" #"Japan East"
subscription_id = "68ed087f-4be0-41e8-a682-b1bce367af23"
domain          = "vaan.eragon123app.com"

global_ips = {
  sun_hni        = ["1.55.242.188/32", "116.97.243.74/32", "103.37.29.230/32", "42.112.114.236/32", "14.160.25.214/32", "42.116.7.14/32"]
  sun_hni_office = ["1.55.242.188/32", "116.97.243.74/32", "103.37.29.230/32", "42.112.114.236/32"]
  sun_hni_server = ["14.160.25.214/32", "42.116.7.14/32"]
  sun_dng        = ["118.69.176.252/32", "14.176.232.181/32", "42.116.19.204/32"]
  sun_hcm        = ["222.253.79.245/32", "203.167.11.86/32", "58.186.32.244/32"]
  sun_jp         = ["150.249.192.115/32"]
}

vnet = {
  vnet_cidr = "10.1.0.0/16"
  subnet_configuration = {
    aks = {
      cidr                            = "10.1.0.0/21"
      default_outbound_access_enabled = false
    }
    agw = {
      cidr = "10.1.8.0/24"
    }
    storage = {
      cidr              = "10.1.9.0/24"
      service_endpoints = ["Microsoft.Storage"]
    }
  }
}

aks = {
  name       = "api"
  version    = "1.30.9"
  dns_prefix = "akswebapp"
  network_profile = {
    network_plugin = "azure"
    network_policy = "azure"
    service_cidr   = "10.160.0.0/16"
    service_cidrs  = ["10.160.0.0/16"]
    ip_versions    = ["IPv4"]
    dns_service_ip = "10.160.0.10"
  }
  default_node_pool = {
    name       = "worker1"
    node_count = 1
    vm_size    = "Standard_DS2_v2"
  }
}

storage = {
  content = {
    name = "azureakscontents"
    blob = {
      account_replication_type = "LRS"
      account_tier             = "Standard"
    }
    container = {
      name = "contents"
    }
  }
}
