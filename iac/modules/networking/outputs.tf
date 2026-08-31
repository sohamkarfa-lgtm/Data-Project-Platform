output "virtual_network_id" {
  description = "Spoke virtual network resource ID."
  value       = azurerm_virtual_network.spoke.id
}

output "virtual_network_name" {
  description = "Spoke virtual network name."
  value       = azurerm_virtual_network.spoke.name
}

output "subnet_ids" {
  description = "Subnet IDs keyed by logical subnet key."
  value       = { for key, subnet in azurerm_subnet.this : key => subnet.id }
}

output "private_dns_zone_ids" {
  description = "Private DNS zone IDs keyed by DNS zone name for zones created by this module."
  value       = { for key, zone in azurerm_private_dns_zone.this : key => zone.id }
}
