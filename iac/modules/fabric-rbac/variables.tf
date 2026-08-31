variable "workspace_ids" {
  description = "Fabric workspace IDs keyed by logical workspace key."
  type        = map(string)
}

variable "assignments" {
  description = "Workspace RBAC assignments keyed by stable assignment key."
  type = map(object({
    workspace_key   = string
    principal_id    = string
    principal_type  = optional(string, "Group")
    role            = string
  }))
  default = {}

  validation {
    condition = alltrue([
      for assignment in values(var.assignments) :
      contains(["Group", "ServicePrincipal", "ServicePrincipalProfile", "User"], assignment.principal_type)
    ])
    error_message = "principal_type must be one of Group, ServicePrincipal, ServicePrincipalProfile, or User."
  }

  validation {
    condition = alltrue([
      for assignment in values(var.assignments) :
      contains(["Admin", "Contributor", "Member", "Viewer"], assignment.role)
    ])
    error_message = "role must be one of Admin, Contributor, Member, or Viewer."
  }
}
