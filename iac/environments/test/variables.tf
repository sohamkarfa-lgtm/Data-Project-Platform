variable "subscription_id" {
  description = "Azure subscription ID for this environment."
  type        = string
}

variable "tenant_id" {
  description = "Azure tenant ID. Leave null to use the current azurerm tenant."
  type        = string
  default     = null
}

variable "location" {
  description = "Azure region for this environment, for example westeurope."
  type        = string
}

variable "project_name" {
  description = "Human-readable project name."
  type        = string
  default     = "Data Project Platform"
}

variable "project_short_name" {
  description = "Short lowercase project token used in resource names."
  type        = string
  default     = "dp"
}

variable "workload_name" {
  description = "Workload tag value."
  type        = string
  default     = "data-platform"
}

variable "cost_center" {
  description = "Cost center tag value."
  type        = string
}

variable "data_classification" {
  description = "Data classification tag value."
  type        = string
  default     = "internal"
}

variable "management_group_id" {
  description = "Optional management group ID for subscription association."
  type        = string
  default     = null
}

variable "associate_subscription_to_management_group" {
  description = "Whether to associate this subscription with management_group_id."
  type        = bool
  default     = false
}

variable "resource_group_names" {
  description = "Optional overrides for platform, network, data, and monitoring resource group names."
  type        = map(string)
  default     = {}
}

variable "vnet_address_space" {
  description = "Address space for the environment spoke VNet."
  type        = list(string)
  default     = ["10.43.0.0/22"]
}

variable "dns_servers" {
  description = "Optional custom DNS servers for the spoke VNet."
  type        = list(string)
  default     = []
}

variable "subnets" {
  description = "Optional subnet overrides keyed by logical subnet key."
  type = map(object({
    name              = string
    address_prefixes  = list(string)
    service_endpoints = optional(list(string), [])
  }))
  default = {}
}

variable "hub_virtual_network_id" {
  description = "Optional existing hub VNet resource ID for peering."
  type        = string
  default     = null
}

variable "allow_forwarded_traffic" {
  description = "Whether spoke-to-hub peering allows forwarded traffic."
  type        = bool
  default     = true
}

variable "use_remote_gateways" {
  description = "Whether spoke-to-hub peering uses remote hub gateways."
  type        = bool
  default     = false
}

variable "create_private_dns_zones" {
  description = "Whether to create private DNS zones in this environment."
  type        = bool
  default     = false
}

variable "private_dns_zone_ids" {
  description = "Existing private DNS zone IDs keyed by blob, dfs, and vault."
  type        = map(string)
  default     = {}
}

variable "key_vault_name" {
  description = "Optional globally unique Key Vault name."
  type        = string
  default     = null
}

variable "key_vault_public_network_access_enabled" {
  description = "Whether public network access is enabled for Key Vault."
  type        = bool
  default     = false
}

variable "key_vault_rbac_assignments" {
  description = "Azure RBAC assignments for Key Vault."
  type = map(object({
    principal_id         = string
    role_definition_name = string
  }))
  default = {}
}

variable "storage_account_name" {
  description = "Optional globally unique ADLS Gen2 storage account name."
  type        = string
  default     = null
}

variable "storage_replication_type" {
  description = "ADLS Gen2 storage replication type."
  type        = string
  default     = "LRS"
}

variable "storage_public_network_access_enabled" {
  description = "Whether public network access is enabled for ADLS Gen2."
  type        = bool
  default     = false
}

variable "storage_allowed_subnet_ids" {
  description = "Subnet IDs allowed through the ADLS Gen2 storage firewall."
  type        = list(string)
  default     = []
}

variable "storage_lifecycle_rules" {
  description = "Optional lifecycle rule overrides for ADLS Gen2."
  type = map(object({
    enabled                    = optional(bool, true)
    prefix_match               = list(string)
    blob_types                 = optional(list(string), ["blockBlob"])
    tier_to_cool_after_days    = optional(number)
    tier_to_archive_after_days = optional(number)
    delete_after_days          = optional(number)
  }))
  default = {}
}

variable "fabric_capacity_name" {
  description = "Optional Fabric capacity Azure resource name."
  type        = string
  default     = null
}

variable "fabric_capacity_sku_name" {
  description = "Fabric capacity SKU, for example F2, F32, or F64."
  type        = string
}

variable "fabric_capacity_administration_members" {
  description = "Fabric capacity administrators. Use Entra user UPNs or service principal object IDs."
  type        = list(string)
}

variable "fabric_capacity_id_override" {
  description = "Optional Fabric capacity GUID. Use this when the Fabric provider cannot look up the capacity created in Azure during the same run."
  type        = string
  default     = null
}

variable "fabric_workspaces" {
  description = "Fabric workspaces keyed by logical workspace key."
  type = map(object({
    name        = string
    purpose     = string
    domain      = string
    description = optional(string)
  }))
  default = {}
}

variable "skip_capacity_state_validation" {
  description = "Whether Fabric workspace capacity state validation should be skipped."
  type        = bool
  default     = false
}

variable "enable_workspace_identity" {
  description = "Whether Fabric workspaces get a system-assigned identity."
  type        = bool
  default     = true
}

variable "fabric_workspace_rbac_assignments" {
  description = "Fabric workspace role assignments keyed by stable assignment key."
  type = map(object({
    workspace_key  = string
    principal_id   = string
    principal_type = optional(string, "Group")
    role           = string
  }))
  default = {}
}

variable "fabric_use_cli" {
  description = "Allow Fabric provider authentication through Azure CLI."
  type        = bool
  default     = true
}

variable "fabric_use_dev_cli" {
  description = "Allow Fabric provider authentication through Azure Developer CLI."
  type        = bool
  default     = false
}

variable "fabric_use_msi" {
  description = "Allow Fabric provider authentication through managed identity."
  type        = bool
  default     = false
}

variable "fabric_use_oidc" {
  description = "Allow Fabric provider authentication through OIDC workload identity."
  type        = bool
  default     = false
}

variable "log_retention_in_days" {
  description = "Log Analytics retention period in days."
  type        = number
  default     = 90
}

variable "monitoring_email_receivers" {
  description = "Azure Monitor action group email receivers keyed by receiver name."
  type        = map(string)
  default     = {}
}

variable "enable_default_diagnostics" {
  description = "Whether to enable default diagnostics for core resources."
  type        = bool
  default     = false
}

variable "diagnostic_targets" {
  description = "Additional diagnostic targets keyed by logical target name."
  type = map(object({
    resource_id         = string
    log_category_groups = optional(list(string), ["allLogs"])
    metrics             = optional(list(string), ["AllMetrics"])
  }))
  default = {}
}

variable "metric_alerts" {
  description = "Azure Monitor metric alerts keyed by logical alert key."
  type = map(object({
    name             = string
    scopes           = list(string)
    metric_namespace = string
    metric_name      = string
    aggregation      = string
    operator         = string
    threshold        = number
    description      = optional(string, "")
    severity         = optional(number, 3)
    frequency        = optional(string, "PT5M")
    window_size      = optional(string, "PT15M")
    enabled          = optional(bool, true)
  }))
  default = {}
}

variable "monthly_budget_amount" {
  description = "Optional monthly subscription budget amount."
  type        = number
  default     = null
}

variable "budget_contact_emails" {
  description = "Budget alert email contacts."
  type        = list(string)
  default     = []
}

variable "budget_start_date" {
  description = "Budget start date in RFC3339 format."
  type        = string
  default     = "2026-08-01T00:00:00Z"
}

variable "budget_end_date" {
  description = "Optional budget end date in RFC3339 format."
  type        = string
  default     = null
}

variable "budget_alert_threshold" {
  description = "Budget alert threshold percentage."
  type        = number
  default     = 80
}

variable "tags" {
  description = "Additional tags for all environment resources."
  type        = map(string)
  default     = {}
}
