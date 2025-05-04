module "engineering_access" {
  source                     = "./modules/team_access"
  app_id                     = var.app_id
  resource_type_id           = var.resource_type_id
  group_name                 = "Engineering Group"
  access_profile_name        = "Engineering Access Profile"
  access_profile_description = "Access for engineers"
  automation_name            = "Engineering Automation"
  automation_description     = "Automation for engineering group"
  group_description          = "Group for engineering team"
}
