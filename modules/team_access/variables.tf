variable "app_id" {
  description = "ID of the app the resources belong to"
  type        = string
}

variable "resource_type_id" {
  description = "The resource type for the group"
  type        = string
}

variable "group_name" {
  description = "Display name for the group"
  type        = string
}

variable "group_description" {
  description = "Description for the group"
  type        = string
}

variable "access_profile_name" {
  description = "Display name for the access profile"
  type        = string
}

variable "access_profile_description" {
  description = "Description for the access profile"
  type        = string
}

variable "automation_name" {
  description = "Display name for the automation"
  type        = string

}
variable "automation_description" {
  description = "Description for the automation"
  type        = string
}
