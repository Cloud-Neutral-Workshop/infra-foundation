locals {
  bootstrap = yamldecode(file("${path.root}/../config/accounts/bootstrap.yaml"))

  bucket_name = coalesce(var.bucket_name, local.bootstrap.state.bucket_name)
  region      = coalesce(var.region, local.bootstrap.region)
  environment = try(local.bootstrap.environment, "bootstrap")
  tags        = try(local.bootstrap.tags, {})
}
