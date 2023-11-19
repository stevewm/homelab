#
# Simple two-file Terraform config to provision an org, projects and VCS-driven workspaces.
#
# If bootstrapping this needs to be commented out on the intial apply and
# uncommented once that has been done to migrate the state using `terraform init`.
# Enter 'tfc' for the workspace name and type 'yes' to migrating the state.
#

terraform {
 required_version = ">= 1.0"

 cloud {
   organization = "steve-homelab"
   workspaces {
     name = "tf-tfc"
   }
 }
}

provider "tfe" {

}

locals {
  variables = {
    "github_pat" : var.github_pat,
  }

  projects = [
    "external"
  ]

  workspaces = {
    # Workspace per directory
    "tf-tfc" : {
      "desc" : "Terraform Cloud configuration"
      "proj" : "external"
    },
    "tf-dns" : {
      "desc" : "DNS configuration"
      "proj" : "external"
    }
  }
}

resource "tfe_organization" "this" {
  name  = "steve-homelab"
  email = "steve@cfg.sh"
}

resource "tfe_oauth_client" "this" {
  organization     = tfe_organization.this.name
  api_url          = "https://api.github.com"
  http_url         = "https://github.com"
  oauth_token      = var.github_pat
  service_provider = "github"
}

resource "tfe_project" "this" {
  for_each     = toset(local.projects)
  name         = each.value
  organization = tfe_organization.this.name
}

resource "tfe_workspace" "this" {
  for_each     = local.workspaces
  name         = each.key
  description  = each.value["desc"]
  organization = tfe_organization.this.name
  project_id   = tfe_project.this[each.value["proj"]].id

  vcs_repo {
    identifier     = "duhio/homelab"
    oauth_token_id = tfe_oauth_client.this.oauth_token_id
  }
  trigger_prefixes  = ["terraform/${each.key}"]
  working_directory = "terraform/${each.key}"
}

resource "tfe_variable" "this" {
  for_each     = local.variables
  key          = each.key
  value        = each.value
  category     = "terraform"
  workspace_id = tfe_workspace.this["tf-tfc"].id
  sensitive    = true
}
