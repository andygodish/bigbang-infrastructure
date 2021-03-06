variable "name" {
  description = "deployment name"
  type        = string
}

variable "vpc_id" {
  description = "id for vpc"
  type        = string
}

variable "tags" {
  description = "the tags to apply to resources"
  type        = map(string)
  default     = {}
}

variable "ami" {
  description = "ami definied in env.yaml"
  type        = string
}

variable "instance_type" {
  description = "type defined in the env.yaml"
  type        = string
}

variable "key_name" {
  description = "The key pair name to install on the bastion"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet ids where the bastion is allowed"
  type        = list(string)
}

variable "random_append" {
  description = "random string appended to certain resources"
  type        = string
}


