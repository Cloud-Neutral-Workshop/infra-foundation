locals {
  bootstrap = var.bootstrap

  config_account_name   = coalesce(var.account_name, try(local.bootstrap.account_name, null))
  config_region         = coalesce(var.region, try(local.bootstrap.region, null))
  config_role_name      = coalesce(var.role_name, try(local.bootstrap.iam.role_name, null))
  config_terraform_user = coalesce(var.terraform_user_name, try(local.bootstrap.iam.terraform_user_name, null))
  environment           = coalesce(try(local.bootstrap.environment, null), try(local.bootstrap.iam.environment, null), "bootstrap")
  extra_tags            = try(local.bootstrap.tags, {})

  role_name           = coalesce(var.existing_role_name, local.config_role_name)
  terraform_user_name = coalesce(var.existing_user_name, local.config_terraform_user)
  state_bucket_name   = coalesce(var.state_bucket_name, try(local.bootstrap.state.bucket_name, null))
  lock_table_name     = coalesce(var.state_lock_table_name, try(local.bootstrap.state.dynamodb_table_name, null))
}

locals {
  account = length(var.account) > 0 ? var.account : {
    account_id  = try(local.bootstrap.account_id, null)
    environment = local.environment
    tags        = local.extra_tags
  }
}
