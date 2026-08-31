variable "name" {
  description = "Optional globally unique storage account name. If omitted, a unique name is generated from name_prefix."
  type        = string
  default     = null

  validation {
    condition     = var.name == null || can(regex("^[a-z0-9]{3,24}$", var.name))
    error_message = "Storage account name must be 3-24 lowercase alphanumeric characters."
  }
}

variable "name_prefix" {
  description = "Prefix used to generate a storage account name when name is omitted."
  type        = string
}

variable "resource_group_name" {
  description = "Resource group for the storage account."
  type        = string
}

variable "location" {
  description = "Azure region for the storage account."
  type        = string
}

variable "account_tier" {
  description = "Storage account performance tier."
  type        = string
  default     = "Standard"
}

variable "replication_type" {
  description = "Storage account replication type."
  type        = string
  default     = "LRS"

  validation {
    condition     = contains(["LRS", "GRS", "RAGRS", "ZRS", "GZRS", "RAGZRS"], var.replication_type)
    error_message = "replication_type must be one of LRS, GRS, RAGRS, ZRS, GZRS, or RAGZRS."
  }
}

variable "access_tier" {
  description = "Default access tier for blobs."
  type        = string
  default     = "Hot"
}

variable "container_names" {
  description = "Medallion zone containers to create."
  type        = list(string)
  default     = ["bronze", "silver", "gold"]
}

variable "lifecycle_rules" {
  description = "Blob lifecycle rules keyed by rule name."
  type = map(object({
    enabled                      = optional(bool, true)
    prefix_match                 = list(string)
    blob_types                   = optional(list(string), ["blockBlob"])
    tier_to_cool_after_days      = optional(number)
    tier_to_archive_after_days   = optional(number)
    delete_after_days            = optional(number)
  }))
  default = {}
}

variable "public_network_access_enabled" {
  description = "Whether public network access is enabled for the storage account."
  type        = bool
  default     = false
}

variable "network_default_action" {
  description = "Storage account network rule default action. Use Deny for private-by-default deployments."
  type        = string
  default     = "Deny"

  validation {
    condition     = var.network_default_action == null || contains(["Allow", "Deny"], var.network_default_action)
    error_message = "network_default_action must be Allow, Deny, or null."
  }
}

variable "network_bypass" {
  description = "Storage account network bypass services."
  type        = list(string)
  default     = ["AzureServices"]
}

variable "allowed_ip_rules" {
  description = "Public IP rules allowed through the storage firewall."
  type        = list(string)
  default     = []
}

variable "allowed_subnet_ids" {
  description = "Subnet IDs allowed through the storage firewall."
  type        = list(string)
  default     = []
}

variable "shared_access_key_enabled" {
  description = "Whether shared key access remains enabled."
  type        = bool
  default     = true
}

variable "default_to_oauth_authentication" {
  description = "Whether data plane requests default to Microsoft Entra authentication."
  type        = bool
  default     = true
}

variable "blob_versioning_enabled" {
  description = "Whether blob versioning is enabled."
  type        = bool
  default     = true
}

variable "blob_delete_retention_days" {
  description = "Soft delete retention period for deleted blobs."
  type        = number
  default     = 7
}

variable "container_delete_retention_days" {
  description = "Soft delete retention period for deleted containers."
  type        = number
  default     = 7
}

variable "private_endpoint_subnet_id" {
  description = "Optional subnet ID for storage private endpoints."
  type        = string
  default     = null
}

variable "private_endpoint_subresource_names" {
  description = "Storage private endpoint subresources to create."
  type        = list(string)
  default     = ["blob", "dfs"]
}

variable "private_dns_zone_ids" {
  description = "Private DNS zone IDs keyed by storage subresource name, for example blob and dfs."
  type        = map(string)
  default     = {}
}

variable "tags" {
  description = "Tags applied to storage resources."
  type        = map(string)
  default     = {}
}
