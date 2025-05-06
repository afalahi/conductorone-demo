module "infrastructure_access" {
  source                     = "./modules/team_access"
  app_id                     = var.app_id
  resource_type_id           = var.resource_type_id
  group_name                 = "Infrastructure Group"
  access_profile_name        = "Infrastructure Access Profile"
  access_profile_description = "Access for Infrastructure team"
  automation_name            = "Infrastructure Automation"
  automation_description     = "Automation for Infrastructure group"
  group_description          = "Group for Infrastructure team"
  group_expression           = "((has(subject.profile.manager) && subject.profile.manager == 'nick.fury@governator.io'))"
}
