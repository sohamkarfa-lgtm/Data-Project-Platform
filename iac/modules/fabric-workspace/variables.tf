variable "capacity_id" {
  description = "Fabric capacity ID assigned to the workspaces. This is the Fabric capacity GUID, not the Azure ARM resource ID."
  type        = string
  default     = null
}

variable "skip_capacity_state_validation" {
  description = "Whether to skip Fabric capacity state validation when assigning workspaces."
  type        = bool
  default     = false
}

variable "enable_workspace_identity" {
  description = "Whether to enable a system-assigned identity for each Fabric workspace."
  type        = bool
  default     = true
}

variable "workspaces" {
  description = "Fabric workspaces keyed by logical workspace key."
  type = map(object({
    name        = string
    purpose     = string
    domain      = string
    description = optional(string)
  }))
}
