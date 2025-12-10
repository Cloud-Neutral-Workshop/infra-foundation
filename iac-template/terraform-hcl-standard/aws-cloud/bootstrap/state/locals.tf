locals {
  bootstrap = var.bootstrap

  bucket_name = coalesce(var.bucket_name, local.bootstrap.state.bucket_name)
  region      = coalesce(var.region, local.bootstrap.region)
  environment = try(local.bootstrap.environment, "bootstrap")
  tags        = try(local.bootstrap.tags, {})
}
