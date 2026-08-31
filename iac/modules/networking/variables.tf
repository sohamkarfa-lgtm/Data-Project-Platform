variable "name" {
  description = "Spoke virtual network name."
  type        = string
}

variable "resource_group_name" {
  description = "Resource group that will contain the spoke network resources."
  type        = string
}

variable "location" {
  description = "Azure region used for network resources."
  type        = string
}

variable "address_space" {
  description = "Address spaces for the spoke virtual network."
  type        = list(string)
}

variable "dns_servers" {
  description = "Optional custom DNS servers for the spoke virtual network."
  type        = list(string)
  default     = []
}

variable "subnets" {
  description = "Subnets to create in the spoke virtual network."
  type = map(object({
    name              = string
    address_prefixes  = list(string)
    service_endpoints = optional(list(string), [])
  }))
}

variable "hub_virtual_network_id" {
  description = "Optional existing hub virtual network resource ID for spoke-to-hub peering."
  type        = string
  default     = null
}

variable "allow_forwarded_traffic" {
  description = "Whether the spoke-to-hub peering allows forwarded traffic."
  type        = bool
  default     = true
}

variable "use_remote_gateways" {
  description = "Whether the spoke peering should use remote hub gateways."
  type        = bool
  default     = false
}

variable "create_private_dns_zones" {
  description = "Whether to create private DNS zones in this module. Keep false when central networking owns DNS."
  type        = bool
  default     = false
}

variable "private_dns_zone_names" {
  description = "Private DNS zones to create when create_private_dns_zones is true."
  type        = list(string)
  default = [
    "privatelink.blob.core.windows.net",
    "privatelink.dfs.core.windows.net",
    "privatelink.vaultcore.azure.net"
  ]
}

variable "tags" {
  description = "Tags applied to network resources."
  type        = map(string)
  default     = {}
}
