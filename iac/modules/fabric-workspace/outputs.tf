output "workspace_ids" {
  description = "Fabric workspace IDs keyed by logical workspace key."
  value       = { for key, workspace in fabric_workspace.this : key => workspace.id }
}

output "workspace_names" {
  description = "Fabric workspace names keyed by logical workspace key."
  value       = { for key, workspace in fabric_workspace.this : key => workspace.display_name }
}

output "workspace_identity_principal_ids" {
  description = "System-assigned identity service principal IDs keyed by logical workspace key when enabled."
  value       = { for key, workspace in fabric_workspace.this : key => try(workspace.identity.service_principal_id, null) }
}
