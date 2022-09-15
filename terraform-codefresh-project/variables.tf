variable "codefresh_token" {}

variable "codefresh_uri" {
  default = "https://g.codefresh.io/api/"
}

variable "codefresh_context" {
  default = "github"
}

variable "pipeline_is_public" {
  description = "Boolean that specifes if the build logs are publicly accessible. Default is kept true such that all engineers can access for logs"
  default     = true
}