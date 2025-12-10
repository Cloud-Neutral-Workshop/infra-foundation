include "root" {
  path = find_in_parent_folders()
}

locals {
  bootstrap_config = include.root.locals.bootstrap_config
}

terraform {
  source = "./"
}

inputs = {
  bucket_name = local.bootstrap_config.state.bucket_name
  region      = local.bootstrap_config.region
}
