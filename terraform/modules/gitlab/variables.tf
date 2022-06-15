variable "name" {
  description = "The name to apply to the external load balancer resources"
  type        = string
}

variable "tags" {
  description = "The tags to apply to resources"
  type        = map(string)
  default     = {}
}

variable "random_append" {
  description = "random 4-character append"
  type        = string
}

