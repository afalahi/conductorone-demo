# ConductorOne Terraform Demo

This repository demonstrates how to manage ConductorOne resources using Terraform. It showcases the creation of  groups, access profiles, and group automations, per team using Terraform modules.

- **modules/team_access/**: Reusable module for provisioning team-specific resources.
- **teams/**: Contains Terraform configurations for individual teams, utilizing the `team_access` module.

## Getting Started

### Prerequisites

- [Terraform](https://www.terraform.io/downloads.html) installed on your machine.
- A ConductorOne account with appropriate API credentials.

### Setup

1. **Clone the repository:**

   ```bash
   git clone https://github.com/afalahi/conductorone-terraform-demo.git
   cd conductorone-terraform-demo

1. Configure your credentials:

Create and update the terraform.tfvars file with your ConductorOne credentials and desired configurations:

```hcl
client_id           = "your-client-id"
client_secret       = "your-client-secret"
app_id              = "your-app-id"
resource_type_id    = "your-resource-type-id"
```

1. Initialize Terraform:

```console
terraform init
terraform plan
terraform apply
```

## Module Usage

Each team configuration (e.g., teams/engineering.tf) utilizes the team_access module to provision resources specific to that team.

```hcl
module "engineering_access" {
  source                     = "../modules/team_access"
  app_id                     = var.app_id
  resource_type_id           = var.resource_type_id
  group_name                 = "Engineering Group"
  access_profile_name        = "Engineering Access Profile"
  access_profile_description = "Access for engineers"
  automation_name            = "Engineering Automation"
  automation_description     = "Automation for engineering group"
}
```

This module creates a C1 group, access profile, and group automation tailored for the Engineering team.

## Notes

Ensure that all required variables are defined either in terraform.tfvars or through environment variables.

The terraform.tfstate file is stored locally. For collaborative environments, consider using remote state backends.

The ConductorOne Terraform provider is sourced from the ConductorOne namespace:

```hcl
terraform {
  required_providers {
    conductorone = {
      source  = "ConductorOne/conductorone"
      version = ">= 1.0.4"
    }
  }
}
```

## Resources

[ConductorOne Terraform Provider Documentation](https://registry.terraform.io/providers/ConductorOne/conductorone/latest/docs)

[ConductorOne Developer Docs](https://www.conductorone.com/docs/developer/terraform/)

[Terraform Official Documentation](https://www.terraform.io/docs)
