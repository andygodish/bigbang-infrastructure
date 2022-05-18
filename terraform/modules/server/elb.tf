resource "aws_elb" "server_elb" {
  name = "${var.name}-${var.random_append}-elb"
  subnets = [var.private_subnet_ids]

  internal = true
  

  listener {
    instance_port     = 6443
    instance_protocol = "tcp"
    lb_port           = 6443
    lb_protocol       = "tcp"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "TCP:6443"
    interval            = 30
  }

  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400

  tags = var.tags

  security_groups = [aws_security_group.rke2_cp_sg.id]
}

resource "aws_elb_attachment" "rke2_initserver_lb_attachment" {
  elb      = aws_elb.rke2_cp_elb.id
  instance = aws_instance.init_server[0].id
}