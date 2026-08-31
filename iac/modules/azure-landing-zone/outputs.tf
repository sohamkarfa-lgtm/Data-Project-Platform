output "resource_group_names" {
  description = "Resource group names keyed by logical role."
  value       = { for key, rg in azurerm_resource_group.this : key => rg.name }
}

output "resource_group_ids" {
  description = "Resource group IDs keyed by logical role."
  value       = { for key, rg in azurerm_resource_group.this : key => rg.id }
}

output "location" {
  description = "Azure region used by the landing-zone resources."
  value       = var.location
}

output "tags" {
  description = "Resolved common tags applied by the module."
  value       = local.tags
}
