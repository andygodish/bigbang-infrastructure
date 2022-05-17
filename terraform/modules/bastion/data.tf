data "aws_instance" "bastion_host_data" {
  filter {
    name   = "tag:Name"
    values = ["${var.name}-bastion-${var.random_append}"]
  }

  # filter {
  #   name   = "tag:test"
  #   values = ["test"]
  # }

  depends_on = [
    aws_autoscaling_group.bastion
  ]
}
