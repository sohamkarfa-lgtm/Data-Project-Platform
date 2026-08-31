output "assignment_ids" {
  description = "Fabric workspace role assignment IDs keyed by assignment key."
  value       = { for key, assignment in fabric_workspace_role_assignment.this : key => assignment.id }
}
