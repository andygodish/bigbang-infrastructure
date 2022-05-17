variable "num_azs" {
  description = "number of availability zones used in the vpc"
  type        = number
}

variable "name" {
  description = "deployment name"
  type        = string
}

variable "vpc_cidr" {
  description = "cidr range for vpc"
  type        = string
}

variable "tags" {
  description = "the tags to apply to resources"
  type        = map(string)
}

variable "aws_region" {
  description = "The AWS region to deploy resources"
  type        = string
}

