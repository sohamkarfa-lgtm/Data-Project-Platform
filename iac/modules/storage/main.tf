resource "random_string" "suffix" {
  length  = 6
  lower   = true
  numeric = true
  special = false
  upper   = false
}

locals {
  normalized_prefix = replace(lower(var.name_prefix), "/[^a-z0-9]/", "")
  generated_name    = substr("st${local.normalized_prefix}${random_string.suffix.result}", 0, 24)
  account_name      = var.name != null && var.name != "" ? var.name : local.generated_name
}

resource "azurerm_storage_account" "this" {
  name                            = local.account_name
  resource_group_name             = var.resource_group_name
  location                        = var.location
  account_tier                    = var.account_tier
  account_replication_type        = var.replication_type
  account_kind                    = "StorageV2"
  access_tier                     = var.access_tier
  is_hns_enabled                  = true
  min_tls_version                 = "TLS1_2"
  allow_nested_items_to_be_public = false
  public_network_access_enabled   = var.public_network_access_enabled
  shared_access_key_enabled       = var.shared_access_key_enabled
  default_to_oauth_authentication = var.default_to_oauth_authentication
  tags                            = var.tags

  blob_properties {
    versioning_enabled = var.blob_versioning_enabled

    delete_retention_policy {
      days = var.blob_delete_retention_days
    }

    container_delete_retention_policy {
      days = var.container_delete_retention_days
    }
  }

  dynamic "network_rules" {
    for_each = var.network_default_action == null ? [] : [1]

    content {
      default_action             = var.network_default_action
      bypass                     = var.network_bypass
      ip_rules                   = var.allowed_ip_rules
      virtual_network_subnet_ids = var.allowed_subnet_ids
    }
  }
}

resource "azurerm_storage_container" "zone" {
  for_each = toset(var.container_names)

  name                  = each.value
  storage_account_id    = azurerm_storage_account.this.id
  container_access_type = "private"
}

resource "azurerm_storage_management_policy" "this" {
  count = length(var.lifecycle_rules) > 0 ? 1 : 0

  storage_account_id = azurerm_storage_account.this.id

  dynamic "rule" {
    for_each = var.lifecycle_rules

    content {
      name    = rule.key
      enabled = rule.value.enabled

      filters {
        prefix_match = rule.value.prefix_match
        blob_types   = rule.value.blob_types
      }

      actions {
        base_blob {
          tier_to_cool_after_days_since_modification_greater_than    = rule.value.tier_to_cool_after_days
          tier_to_archive_after_days_since_modification_greater_than = rule.value.tier_to_archive_after_days
          delete_after_days_since_modification_greater_than          = rule.value.delete_after_days
        }
      }
    }
  }
}

resource "azurerm_private_endpoint" "this" {
  for_each = var.private_endpoint_subnet_id == null ? toset([]) : toset(var.private_endpoint_subresource_names)

  name                = "${local.account_name}-${each.value}-pe"
  resource_group_name = var.resource_group_name
  location            = var.location
  subnet_id           = var.private_endpoint_subnet_id
  tags                = var.tags

  private_service_connection {
    name                           = "${local.account_name}-${each.value}-psc"
    private_connection_resource_id = azurerm_storage_account.this.id
    is_manual_connection           = false
    subresource_names              = [each.value]
  }

  dynamic "private_dns_zone_group" {
    for_each = lookup(var.private_dns_zone_ids, each.value, null) == null ? [] : [lookup(var.private_dns_zone_ids, each.value)]

    content {
      name                 = "default"
      private_dns_zone_ids = [private_dns_zone_group.value]
    }
  }
}
