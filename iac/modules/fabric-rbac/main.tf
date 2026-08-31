resource "fabric_workspace_role_assignment" "this" {
  for_each = var.assignments

  workspace_id = var.workspace_ids[each.value.workspace_key]

  principal = {
    id   = each.value.principal_id
    type = each.value.principal_type
  }

  role = each.value.role
}
