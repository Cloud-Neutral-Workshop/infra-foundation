locals {
  bootstrap = yamldecode(file(abspath(var.bootstrap_config_path)))

  bucket_name = coalesce(var.bucket_name, local.bootstrap.state.bucket_name)
  region      = coalesce(var.region, local.bootstrap.region)
  environment = try(local.bootstrap.environment, "bootstrap")
  tags        = try(local.bootstrap.tags, {})
}
