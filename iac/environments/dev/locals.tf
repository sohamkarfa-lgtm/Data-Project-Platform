locals {
  environment        = "dev"
  source_entity_ids  = ["PLAT-LZ-0001", "PLAT-COMP-0001", "PLAT-STOR-0001", "PLAT-NET-0001", "PLAT-SEC-0001", "PLAT-OPS-0001", "PLAT-ADR-0001", "PLAT-ADR-0002", "PLAT-ADR-0003", "PLAT-ADR-0004"]
  normalized_project = replace(lower(var.project_short_name), "/[^a-z0-9]/", "")
  name_prefix        = "${var.project_short_name}-${local.environment}"

  common_tags = merge(var.tags, {
    environment         = local.environment
    workload            = var.workload_name
    cost_center         = var.cost_center
    data_classification = var.data_classification
    source_entities     = join(",", local.source_entity_ids)
  })

  resource_group_names = merge({
    platform   = "rg-${var.project_short_name}-${local.environment}-platform"
    network    = "rg-${var.project_short_name}-${local.environment}-network"
    data       = "rg-${var.project_short_name}-${local.environment}-data"
    monitoring = "rg-${var.project_short_name}-${local.environment}-monitoring"
  }, var.resource_group_names)

  subnets = merge({
    private_endpoints = {
      name              = "snet-${var.project_short_name}-${local.environment}-private-endpoints"
      address_prefixes  = [cidrsubnet(var.vnet_address_space[0], 2, 0)]
      service_endpoints = []
    }
    workloads = {
      name              = "snet-${var.project_short_name}-${local.environment}-workloads"
      address_prefixes  = [cidrsubnet(var.vnet_address_space[0], 2, 1)]
      service_endpoints = ["Microsoft.Storage", "Microsoft.KeyVault"]
    }
  }, var.subnets)

  fabric_capacity_name = var.fabric_capacity_name != null && var.fabric_capacity_name != "" ? var.fabric_capacity_name : substr("fc${local.normalized_project}${local.environment}", 0, 63)

  fabric_workspaces = length(var.fabric_workspaces) > 0 ? var.fabric_workspaces : {
    core = {
      name        = "fw-${var.project_short_name}-${local.environment}-core"
      purpose     = "development workspace for controlled promotion"
      domain      = "platform"
      description = "Microsoft Fabric development workspace for the data platform."
    }
  }

  storage_lifecycle_rules = length(var.storage_lifecycle_rules) > 0 ? var.storage_lifecycle_rules : {
    bronze_archive = {
      enabled                    = true
      prefix_match               = ["bronze/"]
      blob_types                 = ["blockBlob"]
      tier_to_cool_after_days    = null
      tier_to_archive_after_days = 90
      delete_after_days          = 455
    }
    silver_retention = {
      enabled                    = true
      prefix_match               = ["silver/"]
      blob_types                 = ["blockBlob"]
      tier_to_cool_after_days    = null
      tier_to_archive_after_days = null
      delete_after_days          = 730
    }
    gold_finance_retention = {
      enabled                    = true
      prefix_match               = ["gold/finance/"]
      blob_types                 = ["blockBlob"]
      tier_to_cool_after_days    = null
      tier_to_archive_after_days = null
      delete_after_days          = 2555
    }
    gold_default_retention = {
      enabled                    = true
      prefix_match               = ["gold/non-finance/"]
      blob_types                 = ["blockBlob"]
      tier_to_cool_after_days    = null
      tier_to_archive_after_days = null
      delete_after_days          = 1095
    }
  }

  blob_private_dns_zone_id  = lookup(var.private_dns_zone_ids, "blob", try(module.networking.private_dns_zone_ids["privatelink.blob.core.windows.net"], null))
  dfs_private_dns_zone_id   = lookup(var.private_dns_zone_ids, "dfs", try(module.networking.private_dns_zone_ids["privatelink.dfs.core.windows.net"], null))
  vault_private_dns_zone_id = lookup(var.private_dns_zone_ids, "vault", try(module.networking.private_dns_zone_ids["privatelink.vaultcore.azure.net"], null))

  storage_private_dns_zone_ids = {
    for key, value in {
      blob = local.blob_private_dns_zone_id
      dfs  = local.dfs_private_dns_zone_id
    } : key => value if value != null
  }

  fabric_capacity_id = var.fabric_capacity_id_override != null && var.fabric_capacity_id_override != "" ? var.fabric_capacity_id_override : data.fabric_capacity.this[0].id

  default_diagnostic_targets = var.enable_default_diagnostics ? {
    storage = {
      resource_id         = module.storage.id
      log_category_groups = ["allLogs"]
      metrics             = ["AllMetrics"]
    }
    key_vault = {
      resource_id         = module.key_vault.id
      log_category_groups = ["audit"]
      metrics             = ["AllMetrics"]
    }
    fabric_capacity = {
      resource_id         = module.fabric_capacity.id
      log_category_groups = []
      metrics             = ["AllMetrics"]
    }
  } : {}

  diagnostic_targets = merge(local.default_diagnostic_targets, var.diagnostic_targets)
}
