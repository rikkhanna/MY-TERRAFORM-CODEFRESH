terraform {

  required_providers {
    codefresh = {
      source = "registry.terraform.io/codefresh-io/codefresh"
    }
  }
}

provider "codefresh" {
  api_url = var.codefresh_uri
  token   = var.codefresh_token
}