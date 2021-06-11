# Set management Group Deployment Variables
# Root Managament Group is automatically created.
# and assigned the ID specified in the root_id local variable
locals {
  provider_path = {
    management_groups = "/providers/Microsoft.Management/managementGroups/"
    role_assignment   = "/providers/Microsoft.Authorization/roleAssignments/"
  }
  resource_types = {
    policy_definition     = "Microsoft.Authorization/policyDefinitions"
    policy_set_definition = "Microsoft.Authorization/policySetDefinitions"
  }

  management_groups = {
    "${local.root_id}-platform" = {
      display_name               = upper("platform")
      parent_management_group_id = local.root_id
      subscription_ids           = local.platformMG_subscriptions
      archetype                  = "platform"
    }
    "${local.root_id}-sandbox" = {
      display_name               = upper("sandbox")
      parent_management_group_id = local.root_id
      subscription_ids           = local.sandboxMG_subscriptions
      archetype                  = "dev"
    }
    "${local.root_id}-workloads" = {
      display_name               = upper("workloads")
      parent_management_group_id = local.root_id
      subscription_ids           = local.workloadMG_subscriptions
      archetype                  = "landingzone"
    }
    "${local.root_id}-production" = {
      display_name               = upper("production")
      parent_management_group_id = "${local.root_id}-workloads"
      subscription_ids           = local.productionMG_subscriptions
      archetype                  = "landingzone"
    }
    "${local.root_id}-pre-prod" = {
      display_name               = upper("pre-production")
      parent_management_group_id = "${local.root_id}-workloads"
      subscription_ids           = local.preproductionMG_subscriptions
      archetype                  = "landingzone"
    }
    "${local.root_id}-internal" = {
      display_name               = upper("internal")
      parent_management_group_id = "${local.root_id}-production"
      subscription_ids           = local.internalMG_subscriptions
      archetype                  = "internal"
    }
    "${local.root_id}-web" = {
      display_name               = upper("web facing")
      parent_management_group_id = "${local.root_id}-production"
      subscription_ids           = local.webMG_subscriptions
      archetype                  = "public"
    }
    "${local.root_id}-test" = {
      display_name               = upper("test facing")
      parent_management_group_id = "${local.root_id}-pre-production"
      subscription_ids           = local.test_subscriptions
      archetype                  = "public"
    }
  }





}