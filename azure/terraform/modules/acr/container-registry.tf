resource "azurerm_container_registry" "acr" {
  resource_group_name = var.resource_group_name
  location            = var.location

  name                          = var.acr.name
  sku                           = var.acr.sku
  admin_enabled                 = var.acr.admin_enabled
  public_network_access_enabled = var.acr.public_network_access_enabled
  quarantine_policy_enabled     = var.acr.quarantine_policy_enabled
  retention_policy_in_days      = var.acr.retention_policy_in_days
  trust_policy_enabled          = var.acr.trust_policy_enabled
  zone_redundancy_enabled       = var.acr.zone_redundancy_enabled
  export_policy_enabled         = var.acr.export_policy_enabled
  anonymous_pull_enabled        = var.acr.anonymous_pull_enabled
  data_endpoint_enabled         = var.acr.data_endpoint_enabled
  network_rule_bypass_option    = var.acr.network_rule_bypass_option

  dynamic "georeplications" {
    for_each = var.acr.georeplications
    content {
      location                  = georeplications.value.location
      regional_endpoint_enabled = georeplications.value.regional_endpoint_enabled
      zone_redundancy_enabled   = georeplications.value.zone_redundancy_enabled
    }
  }

  dynamic "network_rule_set" {
    for_each = var.acr.network_rule_set != null ? [var.acr.network_rule_set] : []
    content {
      default_action = network_rule_set.value.default_action

      dynamic "ip_rule" {
        for_each = network_rule_set.value.ip_rules
        content {
          action   = ip_rules.value.action
          ip_range = ip_rules.value.ip_range
        }
      }
    }
  }

  dynamic "identity" {
    for_each = var.acr.identity != null ? [var.acr.identity] : []
    content {
      type         = identity.value.type
      identity_ids = identity.value.identity_ids
    }
  }

  dynamic "encryption" {
    for_each = var.acr.encryption != null ? [var.acr.encryption] : []
    content {
      key_vault_key_id   = encryption.value.key_vault_key_id
      identity_client_id = encryption.value.identity_client_id
    }
  }

  tags = merge(
    var.tags,
    {
      name = var.acr.name
    }
  )
}
