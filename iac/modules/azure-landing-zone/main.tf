locals {
  tags = merge(var.tags, {
    environment         = var.environment
    workload            = var.workload
    cost_center         = var.cost_center
    data_classification = var.data_classification
  })
}

resource "azurerm_resource_group" "this" {
  for_each = var.resource_group_names

  name     = each.value
  location = var.location
  tags     = local.tags
}

resource "azurerm_management_group_subscription_association" "this" {
  count = var.associate_subscription_to_management_group && var.management_group_id != null ? 1 : 0

  management_group_id = var.management_group_id
  subscription_id     = "/subscriptions/${var.subscription_id}"
}
