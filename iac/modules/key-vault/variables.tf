variable "name" {
  description = "Optional globally unique Key Vault name. If omitted, a unique name is generated from name_prefix."
  type        = string
  default     = null

  validation {
    condition     = var.name == null || can(regex("^[a-zA-Z][a-zA-Z0-9-]{1,22}[a-zA-Z0-9]$", var.name))
    error_message = "Key Vault name must be 3-24 alphanumeric/hyphen characters, start with a letter, and end with alphanumeric."
  }
}

variable "name_prefix" {
  description = "Prefix used to generate a Key Vault name when name is omitted."
  type        = string
}

variable "resource_group_name" {
  description = "Resource group for the Key Vault."
  type        = string
}

variable "location" {
  description = "Azure region for the Key Vault."
  type        = string
}

variable "tenant_id" {
  description = "Tenant ID for the Key Vault. Defaults to the current azurerm client tenant."
  type        = string
  default     = null
}

variable "sku_name" {
  description = "Key Vault SKU."
  type        = string
  default     = "standard"

  validation {
    condition     = contains(["standard", "premium"], var.sku_name)
    error_message = "sku_name must be standard or premium."
  }
}

variable "soft_delete_retention_days" {
  description = "Soft delete retention period in days."
  type        = number
  default     = 90
}

variable "purge_protection_enabled" {
  description = "Whether purge protection is enabled."
  type        = bool
  default     = true
}

variable "public_network_access_enabled" {
  description = "Whether public network access is enabled for Key Vault."
  type        = bool
  default     = false
}

variable "rbac_assignments" {
  description = "Azure RBAC assignments for Key Vault."
  type = map(object({
    principal_id         = string
    role_definition_name = string
  }))
  default = {}
}

variable "private_endpoint_subnet_id" {
  description = "Optional subnet ID for a Key Vault private endpoint."
  type        = string
  default     = null
}

variable "private_dns_zone_id" {
  description = "Optional private DNS zone ID for privatelink.vaultcore.azure.net."
  type        = string
  default     = null
}

variable "tags" {
  description = "Tags applied to Key Vault resources."
  type        = map(string)
  default     = {}
}
