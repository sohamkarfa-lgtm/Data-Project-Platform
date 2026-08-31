output "resource_group_names" {
  description = "Resource group names keyed by role."
  value       = module.landing_zone.resource_group_names
}

output "virtual_network_id" {
  description = "Spoke virtual network ID."
  value       = module.networking.virtual_network_id
}

output "subnet_ids" {
  description = "Subnet IDs keyed by logical subnet key."
  value       = module.networking.subnet_ids
}

output "storage_account_name" {
  description = "ADLS Gen2 storage account name."
  value       = module.storage.name
}

output "key_vault_uri" {
  description = "Key Vault URI."
  value       = module.key_vault.vault_uri
}

output "fabric_capacity_azure_resource_id" {
  description = "Azure resource ID of the Fabric capacity."
  value       = module.fabric_capacity.id
}

output "fabric_capacity_id" {
  description = "Fabric capacity GUID used by Fabric workspace resources."
  value       = local.fabric_capacity_id
}

output "fabric_workspace_ids" {
  description = "Fabric workspace IDs keyed by logical workspace key."
  value       = module.fabric_workspaces.workspace_ids
}

output "log_analytics_workspace_id" {
  description = "Log Analytics workspace ID."
  value       = module.monitoring.log_analytics_workspace_id
}
