terraform {
  required_providers {
    conductorone = {
      source  = "ConductorOne/conductorone"
      version = "1.0.4"
    }
  }
}
resource "conductorone_app_resource" "group" {
  app_id               = var.app_id
  app_resource_type_id = var.resource_type_id
  display_name         = var.group_name
  description          = var.group_description

}

resource "conductorone_custom_app_entitlement" "member" {
  app_id               = var.app_id
  app_resource_id      = conductorone_app_resource.group.id
  app_resource_type_id = var.resource_type_id
  display_name         = "Member"
  slug                 = "member"
}
resource "conductorone_custom_app_entitlement" "excluded" {
  app_id               = var.app_id
  app_resource_id      = conductorone_app_resource.group.id
  app_resource_type_id = var.resource_type_id
  display_name         = "Excluded from Rule"
  slug                 = "excluded from rule"
}
resource "conductorone_app_entitlement_automation" "automation" {
  app_id             = var.app_id
  app_entitlement_id = conductorone_custom_app_entitlement.member.id
  app_entitlement_automation_rule_cel = {
    expression = var.group_expression
  }
  display_name = var.automation_name
  description  = var.automation_description
  lifecycle {
    ignore_changes = [
      app_entitlement_automation_rule_basic,
      app_entitlement_automation_rule_none,
      description
    ]
  }
}

resource "conductorone_access_profile" "profile" {
  description                       = var.access_profile_description
  display_name                      = var.access_profile_name
  enrollment_behavior               = "REQUEST_CATALOG_ENROLLMENT_BEHAVIOR_UNSPECIFIED"
  published                         = true
  request_bundle                    = false
  unenrollment_behavior             = "REQUEST_CATALOG_UNENROLLMENT_BEHAVIOR_UNSPECIFIED"
  unenrollment_entitlement_behavior = "REQUEST_CATALOG_UNENROLLMENT_ENTITLEMENT_BEHAVIOR_BYPASS"
  visible_to_everyone               = false
}
resource "conductorone_access_profile_visibility_bindings" "request_group" {
  access_entitlements = [
    {
      app_id = var.app_id
      id     = conductorone_custom_app_entitlement.member.id
    }
  ]
  catalog_id = conductorone_access_profile.profile.id
}
resource "conductorone_bundle_automation" "profile_enrollment" {
  request_catalog_id = conductorone_access_profile.profile.id
  bundle_automation_rule_entitlement = {
    entitlement_refs = [
      {
        app_id = var.app_id
        id     = conductorone_custom_app_entitlement.member.id
      }
    ]
  }
  enabled = true
}
