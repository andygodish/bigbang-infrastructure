resource "aws_security_group" "server_sg" {
  description = "Allow traffic for K8S Control Plane"
  vpc_id      = var.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = var.tags
}

resource "aws_security_group_rule" "server_self_ingress" {
  type              = "ingress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.server_sg.id
}

resource "aws_security_group_rule" "server_cp_ingress" {
  description       = "Ingress Control Plane"
  type              = "ingress"
  from_port         = 6443
  to_port           = 6443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.server_sg.id
}

resource "aws_instance" "server" {
  # name          = "${var.name}-${var.random_append}-server"
  ami           = var.ami
  instance_type = var.instance_type

  root_block_device {
    volume_type = var.storage_type
    volume_size = var.storage_size
  }
  subnet_id                   = var.private_subnet_ids[0]
  vpc_security_group_ids      = [aws_security_group.server_sg.id]
  associate_public_ip_address = false

  iam_instance_profile = aws_iam_instance_profile.server_iam_profile.name

  key_name = var.key_name

  user_data = filebase64("${path.module}/dependencies/user_data.sh")

  tags = var.tags
}

