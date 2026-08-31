variable "environment" {
  description = "Deployment environment name."
  type        = string

  validation {
    condition     = contains(["dev", "test", "prod"], var.environment)
    error_message = "Environment must be one of: dev, test, prod."
  }
}

variable "location" {
  description = "Azure region used for environment resources."
  type        = string
}

variable "subscription_id" {
  description = "Azure subscription ID for this environment."
  type        = string
}

variable "management_group_id" {
  description = "Optional Azure management group ID to associate this environment subscription with."
  type        = string
  default     = null
}

variable "associate_subscription_to_management_group" {
  description = "Whether this module should associate the subscription with management_group_id."
  type        = bool
  default     = false
}

variable "resource_group_names" {
  description = "Named resource groups to create for the environment."
  type        = map(string)
}

variable "workload" {
  description = "Workload tag value."
  type        = string
}

variable "cost_center" {
  description = "Cost center tag value."
  type        = string
}

variable "data_classification" {
  description = "Data classification tag value."
  type        = string
}

variable "tags" {
  description = "Additional tags applied to all landing-zone resources."
  type        = map(string)
  default     = {}
}
