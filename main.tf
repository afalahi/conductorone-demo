terraform {
  required_providers {
    conductorone = {
      source  = "ConductorOne/conductorone"
      version = "1.0.5"
    }
    okta = {
      source  = "okta/okta"
      version = "~> 4.18.0"
    }
  }
}

provider "conductorone" {
  client_id     = var.client_id
  client_secret = var.client_secret
  server_url    = var.server_url
  tenant_domain = var.tenant_domain
}

