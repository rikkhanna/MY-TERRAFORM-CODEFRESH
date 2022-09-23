resource "codefresh_pipeline" "azure-nonprod" {
  depends_on = [codefresh_project.this]

  for_each = { for pipeline in local.pipelines : "${pipeline.name}" => pipeline if(pipeline.env != "prod" && pipeline.platform == "azure" && pipeline.repo != "") }

  name      = join("-", [join("/", [each.value.project, each.value.name]), "nonprod"])
  tags      = concat(["nonprod"], [each.value.team], [join("-", [each.value.team, "non-prod"])])
  is_public = var.pipeline_is_public

  spec {
    concurrency = 1
    priority    = 5

    spec_template {
      repo     = join("/", [each.value.org, each.value.repo])
      path     = "./codefresh.yml"   # PATH_TO_CODEFRESH.YML
      revision = each.value.revision # revision    = "master"
      context  = "github"            #Codefresh Git context. 
    }

    # contexts = [
    # "context1-name",
    # "context2-name",
    # ] # A list of strings representing the contexts (shared_configuration) to be configured for the pipeline

    trigger {
      branch_regex        = "/^(feature\\/.+|develop|main|release\\/.+|hotfix\\/.+|dev\\/.+|bugfix\\/.+|drh\\/.+)$/gi"
      context             = "github"
      description         = "Trigger for codefresh pipelines"
      disabled            = false
      events              = split(",", each.value.triggers)
      modified_files_glob = each.value.modified_files_glob
      name                = join("-", [each.value.repo], ["Trigger"])
      provider            = "github"
      repo                = join("/", [each.value.org, each.value.repo])
      type                = "git"
    }

    # runtime_environment {
    #   name = "ClusterContext/cf-rt-nonprod"
    #   memory = "5000Mi"
    #   cpu   =   "1000m"
    # }

    variables = [
        {
          key = APPLICATION
          value = each.value.app_dir
          encrypted = false
        },
                {
          key = CHANNEL
          value = each.value.channel
          encrypted = false
        },
        {
          key = ENVIRONMENT
          value = each.value.env
          encrypted = false
        },
        {
          key = PLATFORM
          value = each.value.platform
          encrypted = false
        }
    ]


  }
}