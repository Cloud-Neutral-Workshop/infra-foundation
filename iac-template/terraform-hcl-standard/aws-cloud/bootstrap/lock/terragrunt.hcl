include "root" {
  path = find_in_parent_folders()
}

locals {
  root_config      = read_terragrunt_config(find_in_parent_folders())
  bootstrap_config = local.root_config.locals.bootstrap_config
}

dependency "state" {
  config_path = "../state"

  mock_outputs = {
    bucket_name = local.bootstrap_config.state.bucket_name
    region      = local.bootstrap_config.region
  }

  mock_outputs_allowed_terraform_commands = ["plan", "validate"]
}

terraform {
  source = "./"
}

inputs = {
  region = dependency.state.outputs.region
}
