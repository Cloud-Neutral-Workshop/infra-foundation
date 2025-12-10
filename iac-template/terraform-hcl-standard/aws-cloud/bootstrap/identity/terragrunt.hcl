include "root" {
  path = find_in_parent_folders()
}

locals {
  bootstrap_config = include.root.locals.bootstrap_config
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
}
