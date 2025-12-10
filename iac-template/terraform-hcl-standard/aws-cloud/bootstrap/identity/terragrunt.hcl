include "root" {
  path = find_in_parent_folders()
}

locals {
  root_config      = read_terragrunt_config(find_in_parent_folders())
  bootstrap_config = local.root_config.locals.bootstrap_config
  account_file     = find_in_parent_folders("config/accounts/${local.bootstrap_config.account_name}.yaml", "")
  account_config   = fileexists(local.account_file) ? yamldecode(file(local.account_file)) : {
    account_id  = local.bootstrap_config.account_id
    environment = try(local.bootstrap_config.environment, "bootstrap")
    tags        = try(local.bootstrap_config.tags, {})
  }
}

dependency "state" {
  config_path = "../state"

  mock_outputs = {
    bucket_name = local.bootstrap_config.state.bucket_name
    region      = local.bootstrap_config.region
  }

  mock_outputs_allowed_terraform_commands = ["plan", "validate"]
}

dependency "lock" {
  config_path = "../lock"

  mock_outputs = {
    dynamodb_table_name = local.bootstrap_config.state.dynamodb_table_name
    region              = local.bootstrap_config.region
  }

  mock_outputs_allowed_terraform_commands = ["plan", "validate"]
}

terraform {
  source = "./"
}

inputs = {
  region                 = dependency.state.outputs.region
  state_bucket_name      = dependency.state.outputs.bucket_name
  state_lock_table_name  = dependency.lock.outputs.dynamodb_table_name
  bootstrap              = local.bootstrap_config
  account                = local.account_config
}
