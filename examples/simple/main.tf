data "azurerm_client_config" "current" {}

locals {
  root_id                       = "im"
  root_display_name             = "im-asc"
  platformMG_subscriptions      = []
  sandboxMG_subscriptions       = []
  workloadMG_subscriptions      = []
  productionMG_subscriptions    = []
  preproductionMG_subscriptions = []
  webMG_subscriptions           = []
  test_subscriptions            = []
  internalMG_subscriptions      = []
}


# Deploy the Management Group module
module "management_groups" {
  source = "../../"

  root_parent_id = data.azurerm_client_config.current.tenant_id
  root_id        = local.root_id
  root_name      = local.root_display_name
  landing_zones  = local.management_groups
}

provider "azurerm" {
  features {}
}

output "management_groups" {
  value = module.management_groups.management_groups
}