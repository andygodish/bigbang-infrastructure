data "aws_availability_zones" "available" {
  state = "available"
  filter {
    name   = "group-name"
    values = [var.aws_region]
  }
}

locals {
  num_azs = var.num_azs
  
  # Size of the CIDR range, this is added to the VPC CIDR bits
  # For example if the VPC CIDR is 10.0.0.0/16 and the CIDR size is 8, the CIDR will be 10.0.xx.0/24
  cidr_size = 8

  # Step of CIDR range.  How much space to leave between CIDR sets (public, private, intra)
  cidr_step = max(10, local.num_azs)

  # Based on VPC CIDR, create subnet ranges
  cidr_index           = range(local.num_azs)
  public_subnet_cidrs  = [for i in local.cidr_index : cidrsubnet(var.vpc_cidr, local.cidr_size, i)]
  private_subnet_cidrs = [for i in local.cidr_index : cidrsubnet(var.vpc_cidr, local.cidr_size, i + local.cidr_step)]
}

module "vpc" {
  
  # https://github.com/terraform-aws-modules/terraform-aws-vpc
  source = "terraform-aws-modules/vpc/aws" 

  name = var.name
  cidr = var.vpc_cidr

  azs             = data.aws_availability_zones.available.names
  public_subnets  = local.public_subnet_cidrs
  private_subnets = local.private_subnet_cidrs

  enable_nat_gateway     = false
  single_nat_gateway     = true
  one_nat_gateway_per_az = false

  enable_dns_hostnames = true
  enable_dns_support   = true

  # Create EIPs for NAT gateways
  reuse_nat_ips = false

  # Add in required tags for proper AWS CCM integration
  public_subnet_tags = merge({
    "kubernetes.io/cluster/${var.name}" = "shared"
    "kubernetes.io/role/elb"            = "1"
  }, var.tags)

  private_subnet_tags = merge({
    "kubernetes.io/cluster/${var.name}" = "shared"
    "kubernetes.io/role/internal-elb"   = "1"
  }, var.tags)

  tags = merge({
    "kubernetes.io/cluster/${var.name}" = "shared"
  }, var.tags)
}

