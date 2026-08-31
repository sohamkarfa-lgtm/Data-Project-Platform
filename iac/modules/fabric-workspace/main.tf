resource "fabric_workspace" "this" {
  for_each = var.workspaces

  display_name                   = each.value.name
  description                    = coalesce(each.value.description, each.value.purpose)
  capacity_id                    = var.capacity_id
  skip_capacity_state_validation = var.skip_capacity_state_validation
  identity                       = var.enable_workspace_identity ? { type = "SystemAssigned" } : null
}
