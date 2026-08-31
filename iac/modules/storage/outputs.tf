output "id" {
  description = "Storage account resource ID."
  value       = azurerm_storage_account.this.id
}

output "name" {
  description = "Storage account name."
  value       = azurerm_storage_account.this.name
}

output "primary_dfs_endpoint" {
  description = "Primary DFS endpoint for ADLS Gen2."
  value       = azurerm_storage_account.this.primary_dfs_endpoint
}

output "container_names" {
  description = "Medallion storage container names."
  value       = [for container in azurerm_storage_container.zone : container.name]
}

output "private_endpoint_ids" {
  description = "Storage private endpoint IDs keyed by subresource name."
  value       = { for key, endpoint in azurerm_private_endpoint.this : key => endpoint.id }
}
