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

terraform {
  source = "./"
}

inputs = {
  region = dependency.state.outputs.region
}
