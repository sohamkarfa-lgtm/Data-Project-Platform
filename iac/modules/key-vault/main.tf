data "azurerm_client_config" "current" {}

resource "random_string" "suffix" {
  length  = 6
  lower   = true
  numeric = true
  special = false
  upper   = false
}

locals {
  normalized_prefix = replace(lower(var.name_prefix), "/[^a-z0-9]/", "")
  generated_name    = substr("kv${local.normalized_prefix}${random_string.suffix.result}", 0, 24)
  name              = var.name != null && var.name != "" ? var.name : local.generated_name
}

resource "azurerm_key_vault" "this" {
  name                          = local.name
  resource_group_name           = var.resource_group_name
  location                      = var.location
  tenant_id                     = coalesce(var.tenant_id, data.azurerm_client_config.current.tenant_id)
  sku_name                      = var.sku_name
  soft_delete_retention_days    = var.soft_delete_retention_days
  purge_protection_enabled      = var.purge_protection_enabled
  enable_rbac_authorization     = true
  public_network_access_enabled = var.public_network_access_enabled
  tags                          = var.tags

  dynamic "network_acls" {
    for_each = var.public_network_access_enabled ? [] : [1]

    content {
      bypass         = "AzureServices"
      default_action = "Deny"
    }
  }
}

resource "azurerm_role_assignment" "this" {
  for_each = var.rbac_assignments

  scope                = azurerm_key_vault.this.id
  role_definition_name = each.value.role_definition_name
  principal_id         = each.value.principal_id
}

resource "azurerm_private_endpoint" "this" {
  count = var.private_endpoint_subnet_id == null ? 0 : 1

  name                = "${local.name}-pe"
  resource_group_name = var.resource_group_name
  location            = var.location
  subnet_id           = var.private_endpoint_subnet_id
  tags                = var.tags

  private_service_connection {
    name                           = "${local.name}-psc"
    private_connection_resource_id = azurerm_key_vault.this.id
    is_manual_connection           = false
    subresource_names              = ["vault"]
  }

  dynamic "private_dns_zone_group" {
    for_each = var.private_dns_zone_id == null ? [] : [var.private_dns_zone_id]

    content {
      name                 = "default"
      private_dns_zone_ids = [private_dns_zone_group.value]
    }
  }
}
