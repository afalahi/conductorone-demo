module "dev_access" {
  source                     = "./modules/team_access"
  app_id                     = var.app_id
  resource_type_id           = var.resource_type_id
  group_name                 = "Developer Group"
  access_profile_name        = "Developer Access Profile"
  access_profile_description = "Access for Developer team"
  automation_name            = "Developer Automation"
  automation_description     = "Automation for Developer group"
  group_description          = "Group for Developer team"
  group_expression           = "((has(subject.profile.manager) && subject.profile.manager == 'nick.fury@governator.io'))"
}
