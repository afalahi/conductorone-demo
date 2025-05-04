terraform {
  required_providers {
    conductorone = {
      source  = "ConductorOne/conductorone"
      version = "1.0.4"
    }
  }
}

provider "conductorone" {
  client_id     = var.client_id
  client_secret = var.client_secret
  server_url    = var.server_url
  tenant_domain = var.tenant_domain
}

resource "conductorone_app_resource" "engineering_group" {
  app_id               = var.app_id
  app_resource_type_id = var.resource_type_id
  display_name         = "Find top level manager"
}
resource "conductorone_app_entitlement_automation" "engineering_group" {
  app_id             = var.app_id
  app_entitlement_id = "2oUqgbngdXJqjgxNIVnYyS4mxJ6"

  lifecycle {
    ignore_changes = [
      app_entitlement_automation_rule_cel,
      display_name,
      description
    ]
  }
}

# use the data to update the existing access profile
resource "conductorone_access_profile" "engineering_profile" {
  display_name   = "TF Update 2 - Engineering Team"
  description    = "Updated name for the access profile"
  published      = false
  request_bundle = false
}


resource "conductorone_app_resource" "DevOps_group" {
  app_id               = var.app_id
  app_resource_type_id = var.resource_type_id
  display_name         = "My DevOps Group"

}

resource "conductorone_custom_app_entitlement" "DevOps_group" {
  app_id               = var.app_id
  app_resource_id      = conductorone_app_resource.DevOps_group.id
  app_resource_type_id = var.resource_type_id
  display_name         = "Member"
  slug                 = "member"
}
resource "conductorone_custom_app_entitlement" "DevOps_group_excluded" {
  app_id               = var.app_id
  app_resource_id      = conductorone_app_resource.DevOps_group.id
  app_resource_type_id = var.resource_type_id
  display_name         = "Excluded from Rule"
  slug                 = "excluded from rule"
}
resource "conductorone_app_entitlement_automation" "DevOps_group" {
  app_id             = var.app_id
  app_entitlement_id = conductorone_custom_app_entitlement.DevOps_group.id
  app_entitlement_automation_rule_cel = {
    expression = "((has(subject.profile.department) && subject.profile.department=='engineering'))"
  }
  display_name = "Engineering Group Automation"
  lifecycle {
    ignore_changes = [
      app_entitlement_automation_rule_basic,
      app_entitlement_automation_rule_none,
      description
    ]
  }
}
