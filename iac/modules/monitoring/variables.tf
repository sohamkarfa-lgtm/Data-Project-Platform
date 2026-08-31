variable "log_analytics_workspace_name" {
  description = "Log Analytics workspace name."
  type        = string
}

variable "resource_group_name" {
  description = "Resource group for monitoring resources."
  type        = string
}

variable "location" {
  description = "Azure region for monitoring resources."
  type        = string
}

variable "log_analytics_sku" {
  description = "Log Analytics workspace SKU."
  type        = string
  default     = "PerGB2018"
}

variable "log_retention_in_days" {
  description = "Log Analytics retention period in days."
  type        = number
  default     = 90
}

variable "email_receivers" {
  description = "Email receivers for the default action group, keyed by receiver name."
  type        = map(string)
  default     = {}
}

variable "action_group_name" {
  description = "Azure Monitor action group name."
  type        = string
}

variable "action_group_short_name" {
  description = "Azure Monitor action group short name, maximum 12 characters."
  type        = string
}

variable "diagnostic_targets" {
  description = "Diagnostic settings to enable, keyed by logical target name."
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
    name              = string
    scopes            = list(string)
    metric_namespace  = string
    metric_name       = string
    aggregation       = string
    operator          = string
    threshold         = number
    description       = optional(string, "")
    severity          = optional(number, 3)
    frequency         = optional(string, "PT5M")
    window_size       = optional(string, "PT15M")
    enabled           = optional(bool, true)
  }))
  default = {}
}

variable "subscription_id" {
  description = "Subscription ID for optional subscription budget."
  type        = string
}

variable "monthly_budget_amount" {
  description = "Optional monthly subscription budget amount."
  type        = number
  default     = null
}

variable "budget_name" {
  description = "Subscription budget name."
  type        = string
}

variable "budget_start_date" {
  description = "Budget start date in RFC3339 format."
  type        = string
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

variable "budget_contact_emails" {
  description = "Budget notification email addresses."
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "Tags applied to monitoring resources."
  type        = map(string)
  default     = {}
}
