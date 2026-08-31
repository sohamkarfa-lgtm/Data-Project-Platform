output "id" {
  description = "Azure resource ID of the Fabric capacity."
  value       = azurerm_fabric_capacity.this.id
}

output "name" {
  description = "Fabric capacity display/resource name."
  value       = azurerm_fabric_capacity.this.name
}

output "sku_name" {
  description = "Fabric capacity SKU name."
  value       = var.sku_name
}
