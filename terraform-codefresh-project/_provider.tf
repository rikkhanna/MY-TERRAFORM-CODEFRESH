# terraform {

#   required_providers {
#     codefresh = {
#       source = "registry.terraform.io/codefresh-io/codefresh"
#     }
#   }
# }

# provider "codefresh" {
#   api_url = var.codefresh_uri
#   token   = var.codefresh_token
# }

terraform {
  required_providers {
    codefresh = {
      source = "codefresh-io/codefresh"
      version = "0.0.24"
    }
  }
}

provider "codefresh" {
  api_url = var.codefresh_uri
  token   = var.codefresh_token
}