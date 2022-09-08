resource "codefresh_project" "this" {
    for_each = local.teams
    name = join("", [each.key, ""])
    tags = [each.key]
  
}