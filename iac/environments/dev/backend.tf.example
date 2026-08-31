terraform {
  backend "azurerm" {
    resource_group_name  = "rg-terraform-state-dev"
    storage_account_name = "stterraformstatedev"
    container_name       = "tfstate"
    key                  = "fabric-platform/dev.tfstate"
  }
}
