#modules/acr/_variables.tf
#basic
variable "location" {
  description = "Location of environment"
  type        = string
}
variable "resource_group_name" {
  description = "Name of resource group"
  type        = string
}

#tag
variable "tags" {
  description = "(Optional) Common tags"
  type        = map(string)
  default     = null
}

#acr
variable "acr" {
  description = "All configuration to Provides an Azure Container Registry Repository."
  type = object({
    name          = string
    sku           = optional(string, "Basic")
    admin_enabled = optional(bool, false)
    georeplications = optional(list(object({
      location                  = string
      regional_endpoint_enabled = optional(bool, null)
      zone_redundancy_enabled   = optional(bool, false)
    })), [])
    network_rule_set = optional(object({
      default_action = optional(string, "Allow")
      ip_rules = optional(list(object({
        action   = string
        ip_range = string
      })), [])
      virtual_network_subnet_id = optional(string, null)
    }), null)
    public_network_access_enabled = optional(bool, true)
    quarantine_policy_enabled     = optional(bool, null)
    retention_policy_in_days      = optional(number, null)
    trust_policy_enabled          = optional(bool, false)
    zone_redundancy_enabled       = optional(bool, false)
    export_policy_enabled         = optional(bool, true)
    anonymous_pull_enabled        = optional(bool, null)
    data_endpoint_enabled         = optional(bool, null)
    network_rule_bypass_option    = optional(string, "AzureServices")
    identity = optional(object({
      type         = string
      identity_ids = optional(list(string), [])
    }), null)
    encryption = optional(object({
      key_vault_key_id   = string
      identity_client_id = string
    }), null)
  })
}
