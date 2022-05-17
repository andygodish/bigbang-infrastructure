resource "aws_security_group" "bastion_sg" {
  name_prefix = "${var.name}-${var.random_append}-bastion-"
  description = "${var.name} bastion"
  vpc_id      = var.vpc_id

  # Allow all egress
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = var.tags
}

resource "aws_launch_template" "bastion" {

  name_prefix   = "${var.name}-bastion-"
  description   = "Bastion launch template for ${var.name} cluster"
  image_id      = var.ami
  instance_type = var.instance_type
  key_name      = var.key_name

  network_interfaces {
    associate_public_ip_address = true
    security_groups             = ["${aws_security_group.bastion_sg.id}"]
  }

  update_default_version = true
  user_data              = filebase64("${path.module}/dependencies/install_prereqs.sh")

  tag_specifications {
    resource_type = "instance"
    tags          = merge({ "Name" = "${var.name}-bastion-${var.random_append}" }, var.tags)
  }
}

resource "aws_autoscaling_group" "bastion" {
  name_prefix      = "${var.name}-bastion-"
  max_size         = 2
  min_size         = 1
  desired_capacity = 1

  vpc_zone_identifier = var.subnet_ids

  launch_template {
    id      = aws_launch_template.bastion.id
    version = "$Latest"
  }
}


