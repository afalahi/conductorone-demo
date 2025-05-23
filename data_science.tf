module "data_science_access" {
  source                     = "./modules/team_access"
  app_id                     = var.app_id
  resource_type_id           = var.resource_type_id
  group_name                 = "Data Scientists Group"
  access_profile_name        = "Data Scientists Access Profile"
  access_profile_description = "Access for Data Science team"
  automation_name            = "Data Scientists Automation"
  automation_description     = "Automation for Data Science group"
  group_description          = "Group for Data Scientists team"
  group_expression           = "((has(subject.profile.manager) && subject.profile.manager == 'nick.fury@governator.io'))"
}
