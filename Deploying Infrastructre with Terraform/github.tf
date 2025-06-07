terraform {
    required_providers {
        github = {
            source = "integrations/github"
            version = "~> 5.0"
        }
    }
}

data "local_file" "github_token_file" {
  filename = "${path.module}/secrets.txt"
}

provider "github" {
    token = data.local_file.github_token_file.content
}

resource "github_repository" "terraform-example-repo" {
  name          = "terraform-example-repo"
  description   = "Deployed via Terraform"
  visibility    = "private"
}