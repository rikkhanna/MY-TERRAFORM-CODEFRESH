locals {
  az-workloads = {
    "az-workloads" = {
      pipelines : [
        {
          name : "04-Terraform-Language-Syntax",
          repo : "terraform-on-azure-cloud",
          revision : "main",
          env : "nonprod",
          platform : "azure",
          app_dir : "04-Terraform-Language-Syntax",
          channel : "./",
          modified_files_glob : "04-Terraform-Language-Syntax/**"
        }

      ]
    }
  }
}