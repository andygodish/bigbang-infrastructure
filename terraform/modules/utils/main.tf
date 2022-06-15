resource "random_string" "random_append" {
  length  = 4
  special = false
  lower = true
  upper = false
  number = true
}