#
# Due to a bug when migrating state to TFC, the lineage changes and
# this results in TFC trying to
#
terraform {
  required_version = ">= 1.4"

  cloud {
    organization = "steve-homelab"
    workspaces {
      name = "tf-bootstrap"
    }
  }
}

provider "tfe" {
  # Intentionally left blank - TFC token fetched from $TFE_TOKEN
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

resource "tfe_workspace" "this" {
  name         = "tf-bootstrap"
  description  = "TFC Bootstrapping"
  organization = tfe_organization.this.name
  project_id   = tfe_project.this[each.value["proj"]].id

  vcs_repo {
    identifier     = "duhio/homelab"
    oauth_token_id = tfe_oauth_client.this.oauth_token_id
  }
  working_directory = "terraform/${each.key}"
}
