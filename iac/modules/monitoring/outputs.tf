output "log_analytics_workspace_id" {
  description = "Log Analytics workspace resource ID."
  value       = azurerm_log_analytics_workspace.this.id
}

output "log_analytics_workspace_name" {
  description = "Log Analytics workspace name."
  value       = azurerm_log_analytics_workspace.this.name
}

output "action_group_id" {
  description = "Action group ID, when created."
  value       = try(azurerm_monitor_action_group.this[0].id, null)
}

output "budget_id" {
  description = "Subscription budget ID, when created."
  value       = try(azurerm_consumption_budget_subscription.monthly[0].id, null)
}
