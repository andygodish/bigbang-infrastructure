locals {
  env = merge(
    yamldecode(file(find_in_parent_folders("region.yaml"))),
    yamldecode(file(find_in_parent_folders("env.yaml")))
  )
}

terraform {
  source = "${path_relative_from_include()}//modules/pharos"
}

include {
  path = find_in_parent_folders()
}

dependency "utils" {
  config_path = "../utils"
  mock_outputs = {
    random_append = "mock_random_append"
  }
}

inputs = {
    name = local.env.name
    random_append = dependency.utils.outputs.random_append
    tags = merge(local.env.region_tags, local.env.tags, {})
}