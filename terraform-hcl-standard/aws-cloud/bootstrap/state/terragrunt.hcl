include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "${get_parent_terragrunt_dir()}/..//bootstrap/state"
}

inputs = {
  bootstrap_config_path = coalesce(
    trimspace(get_env("BOOTSTRAP_CONFIG_PATH", "")),
    null
  )
}
