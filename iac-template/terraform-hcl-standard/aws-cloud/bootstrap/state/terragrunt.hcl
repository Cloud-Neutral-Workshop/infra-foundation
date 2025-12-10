include "root" {
  path = find_in_parent_folders()
}

locals {
  root_config      = read_terragrunt_config(find_in_parent_folders())
  bootstrap_config = local.root_config.locals.bootstrap_config
}

terraform {
  source = "./"
}

inputs = {
  bucket_name = local.bootstrap_config.state.bucket_name
  region      = local.bootstrap_config.region
}
