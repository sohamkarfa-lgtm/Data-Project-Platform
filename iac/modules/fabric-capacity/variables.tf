variable "name" {
  description = "Fabric capacity Azure resource name. Use lowercase alphanumeric characters for compatibility with Microsoft.Fabric/capacities."
  type        = string

  validation {
    condition     = can(regex("^[a-z][a-z0-9]{2,62}$", var.name))
    error_message = "Fabric capacity name must be 3-63 lowercase alphanumeric characters and start with a letter."
  }
}

variable "resource_group_name" {
  description = "Resource group for the Fabric capacity Azure resource."
  type        = string
}

variable "location" {
  description = "Azure region for the Fabric capacity."
  type        = string
}

variable "sku_name" {
  description = "Fabric capacity SKU."
  type        = string

  validation {
    condition     = contains(["F2", "F4", "F8", "F16", "F32", "F64", "F128", "F256", "F512", "F1024", "F2048"], var.sku_name)
    error_message = "sku_name must be a valid Microsoft Fabric F SKU."
  }
}

variable "administration_members" {
  description = "Capacity administrators. Use Entra user UPNs or service principal object IDs."
  type        = list(string)

  validation {
    condition     = length(var.administration_members) > 0
    error_message = "At least one Fabric capacity administration member is required."
  }
}

variable "tags" {
  description = "Tags applied to the Fabric capacity Azure resource."
  type        = map(string)
  default     = {}
}
