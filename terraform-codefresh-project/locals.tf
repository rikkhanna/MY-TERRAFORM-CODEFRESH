locals {
  teams = merge(local.az-workloads) #  Multiple entries are allowed

  #   user_ids = tomap({
  #     for u in data.codefresh_current_account.acc.users :
  #     u.name => u.id
  #   })

  #   admins = {
  #     members : [
  #         "rishabh_khanna"
  #     ]
  #   }
  

  pipelines = flatten([
    for key, value in local.teams : [
      for pipeline in value.pipelines : {
        name                = pipeline.name
        org                 = try(pipeline.org, "rikkhanna")
        repo                = pipeline.repo
        revision            = try(pipeline.revision, "main")
        prod_revision       = try(pipeline.prod_revision_override, "master")
        team                = key
        project             = key
        env                 = pipeline.env
        platform            = pipeline.platform
        modified_files_glob = pipeline.modified_files_glob
        app_dir             = pipeline.app_dir
        channel             = pipeline.channel
        triggers            = join(",", ["push.heads", "push.tags"])
      }
    ]
  ])
}