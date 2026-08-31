module "landing_zone" {
  source = "../../modules/azure-landing-zone"

  environment                                = local.environment
  location                                   = var.location
  subscription_id                            = var.subscription_id
  management_group_id                        = var.management_group_id
  associate_subscription_to_management_group = var.associate_subscription_to_management_group
  resource_group_names                       = local.resource_group_names
  workload                                   = var.workload_name
  cost_center                                = var.cost_center
  data_classification                        = var.data_classification
  tags                                       = var.tags
}

module "networking" {
  source = "../../modules/networking"

  name                     = "vnet-${var.project_short_name}-${local.environment}-spoke"
  resource_group_name      = module.landing_zone.resource_group_names["network"]
  location                 = module.landing_zone.location
  address_space            = var.vnet_address_space
  dns_servers              = var.dns_servers
  subnets                  = local.subnets
  hub_virtual_network_id   = var.hub_virtual_network_id
  allow_forwarded_traffic  = var.allow_forwarded_traffic
  use_remote_gateways      = var.use_remote_gateways
  create_private_dns_zones = var.create_private_dns_zones
  tags                     = local.common_tags
}

module "key_vault" {
  source = "../../modules/key-vault"

  name                          = var.key_vault_name
  name_prefix                   = local.name_prefix
  resource_group_name           = module.landing_zone.resource_group_names["platform"]
  location                      = module.landing_zone.location
  tenant_id                     = var.tenant_id
  public_network_access_enabled = var.key_vault_public_network_access_enabled
  rbac_assignments              = var.key_vault_rbac_assignments
  private_endpoint_subnet_id    = try(module.networking.subnet_ids["private_endpoints"], null)
  private_dns_zone_id           = local.vault_private_dns_zone_id
  tags                          = local.common_tags
}

module "storage" {
  source = "../../modules/storage"

  name                          = var.storage_account_name
  name_prefix                   = "${local.normalized_project}${local.environment}"
  resource_group_name           = module.landing_zone.resource_group_names["data"]
  location                      = module.landing_zone.location
  replication_type              = var.storage_replication_type
  lifecycle_rules               = local.storage_lifecycle_rules
  public_network_access_enabled = var.storage_public_network_access_enabled
  allowed_subnet_ids            = var.storage_allowed_subnet_ids
  private_endpoint_subnet_id    = try(module.networking.subnet_ids["private_endpoints"], null)
  private_dns_zone_ids          = local.storage_private_dns_zone_ids
  tags                          = local.common_tags
}

module "fabric_capacity" {
  source = "../../modules/fabric-capacity"

  name                   = local.fabric_capacity_name
  resource_group_name    = module.landing_zone.resource_group_names["platform"]
  location               = module.landing_zone.location
  sku_name               = var.fabric_capacity_sku_name
  administration_members = var.fabric_capacity_administration_members
  tags                   = local.common_tags
}

data "fabric_capacity" "this" {
  count = var.fabric_capacity_id_override == null || var.fabric_capacity_id_override == "" ? 1 : 0

  display_name = module.fabric_capacity.name
  depends_on   = [module.fabric_capacity]
}

module "fabric_workspaces" {
  source = "../../modules/fabric-workspace"

  capacity_id                    = local.fabric_capacity_id
  skip_capacity_state_validation = var.skip_capacity_state_validation
  enable_workspace_identity      = var.enable_workspace_identity
  workspaces                     = local.fabric_workspaces
}

module "fabric_rbac" {
  source = "../../modules/fabric-rbac"

  workspace_ids = module.fabric_workspaces.workspace_ids
  assignments   = var.fabric_workspace_rbac_assignments
}

module "monitoring" {
  source = "../../modules/monitoring"

  log_analytics_workspace_name = "log-${var.project_short_name}-${local.environment}"
  resource_group_name          = module.landing_zone.resource_group_names["monitoring"]
  location                     = module.landing_zone.location
  log_retention_in_days        = var.log_retention_in_days
  email_receivers              = var.monitoring_email_receivers
  action_group_name            = "ag-${var.project_short_name}-${local.environment}-platform"
  action_group_short_name      = "ag-${local.environment}"
  diagnostic_targets           = local.diagnostic_targets
  metric_alerts                = var.metric_alerts
  subscription_id              = var.subscription_id
  monthly_budget_amount        = var.monthly_budget_amount
  budget_name                  = "budget-${var.project_short_name}-${local.environment}"
  budget_start_date            = var.budget_start_date
  budget_end_date              = var.budget_end_date
  budget_alert_threshold       = var.budget_alert_threshold
  budget_contact_emails        = var.budget_contact_emails
  tags                         = local.common_tags
}
