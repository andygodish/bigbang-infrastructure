# This file sets up a bastion server (aka jump box) in AWS to access the RKE2 cluster from the internet through SSH

locals {
  env = merge(
    yamldecode(file(find_in_parent_folders("region.yaml"))),
    yamldecode(file(find_in_parent_folders("env.yaml")))
  )
  # You will need to subscribe to this image: https://aws.amazon.com/marketplace/pp?sku=cynhm1j9d2839l7ehzmnes1n0
  # image_id = run_cmd("sh", "-c", "aws ec2 describe-images --owners 'aws-marketplace' --filters 'Name=product-code,Values=cynhm1j9d2839l7ehzmnes1n0' --query 'sort_by(Images, &CreationDate)[-1].[ImageId]' --output 'text'")
  image_id = "ami-017e342d9500ef3b2"
}

terraform {
  source = "${path_relative_from_include()}//modules/bastion"
}

include {
  path = find_in_parent_folders()
}

dependency "vpc" {
  config_path = "../vpc"
  mock_outputs = {
    vpc_id = "mock_vpc_id"
    public_subnet_ids = ["mock_pub_subnet1"]
  }
}

dependency "ssh" {
  config_path = "../ssh"
  mock_outputs = {
    public_key = "mock_public_key"
    key_name = "mock_key_name"
  }
}

dependency "utils" {
  config_path = "../utils"
  mock_outputs = {
    random_append = "mock_random_append"
  }
}

inputs = {
  name  = local.env.name
  vpc_id = dependency.vpc.outputs.vpc_id
  subnet_ids = dependency.vpc.outputs.public_subnet_ids
  ami = local.image_id
  instance_type = local.env.bastion.type
  key_name = dependency.ssh.outputs.key_name
  tags = merge(local.env.region_tags, local.env.tags, {})
  random_append = dependency.utils.outputs.random_append
}
