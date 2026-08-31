provider "azurerm" {
  subscription_id = var.subscription_id
  tenant_id       = var.tenant_id

  features {}
}

provider "fabric" {
  use_cli     = var.fabric_use_cli
  use_dev_cli = var.fabric_use_dev_cli
  use_msi     = var.fabric_use_msi
  use_oidc    = var.fabric_use_oidc
}
