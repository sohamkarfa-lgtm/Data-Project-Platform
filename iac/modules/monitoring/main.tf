resource "azurerm_log_analytics_workspace" "this" {
  name                = var.log_analytics_workspace_name
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = var.log_analytics_sku
  retention_in_days   = var.log_retention_in_days
  tags                = var.tags
}

resource "azurerm_monitor_action_group" "this" {
  count = length(var.email_receivers) > 0 ? 1 : 0

  name                = var.action_group_name
  resource_group_name = var.resource_group_name
  short_name          = var.action_group_short_name
  tags                = var.tags

  dynamic "email_receiver" {
    for_each = var.email_receivers

    content {
      name                    = email_receiver.key
      email_address           = email_receiver.value
      use_common_alert_schema = true
    }
  }
}

resource "azurerm_monitor_diagnostic_setting" "this" {
  for_each = var.diagnostic_targets

  name                       = "${each.key}-diagnostics"
  target_resource_id         = each.value.resource_id
  log_analytics_workspace_id = azurerm_log_analytics_workspace.this.id

  dynamic "enabled_log" {
    for_each = each.value.log_category_groups

    content {
      category_group = enabled_log.value
    }
  }

  dynamic "metric" {
    for_each = each.value.metrics

    content {
      category = metric.value
      enabled  = true
    }
  }
}

resource "azurerm_monitor_metric_alert" "this" {
  for_each = var.metric_alerts

  name                = each.value.name
  resource_group_name = var.resource_group_name
  scopes              = each.value.scopes
  description         = each.value.description
  severity            = each.value.severity
  frequency           = each.value.frequency
  window_size         = each.value.window_size
  enabled             = each.value.enabled
  tags                = var.tags

  criteria {
    metric_namespace = each.value.metric_namespace
    metric_name      = each.value.metric_name
    aggregation      = each.value.aggregation
    operator         = each.value.operator
    threshold        = each.value.threshold
  }

  dynamic "action" {
    for_each = length(azurerm_monitor_action_group.this) == 0 ? [] : [azurerm_monitor_action_group.this[0].id]

    content {
      action_group_id = action.value
    }
  }
}

resource "azurerm_consumption_budget_subscription" "monthly" {
  count = var.monthly_budget_amount == null ? 0 : 1

  name            = var.budget_name
  subscription_id = "/subscriptions/${var.subscription_id}"
  amount          = var.monthly_budget_amount
  time_grain      = "Monthly"

  time_period {
    start_date = var.budget_start_date
    end_date   = var.budget_end_date
  }

  dynamic "notification" {
    for_each = length(var.budget_contact_emails) == 0 ? [] : [1]

    content {
      enabled        = true
      threshold      = var.budget_alert_threshold
      operator       = "EqualTo"
      contact_emails = var.budget_contact_emails
    }
  }
}
