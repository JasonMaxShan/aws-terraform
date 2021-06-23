provider "aws" {
  region = local.region
}
######################################################################
locals {
  region = "${var.region}"
}
######################################################################
module "alb" {
  source  = "../terraform-aws-modules/terraform-aws-alb"

  name = "${var.name}"

  load_balancer_type = "application"

  vpc_id             = "${var.vpc_id}"
  subnets            = "${var.subnets}"
  security_groups    = "${var.security_groups}"

  

  target_groups = [
    {
      name      = "${var.target_group_name}"
      backend_protocol = "HTTP"
      backend_port     = "${var.tg_port}"
      target_type      = "instance"
      deregistration_delay = 30
      health_check = {
        interval            = 5
        healthy_threshold   = 2
        unhealthy_threshold = 2
        timeout             = 3
      }
    }
  ]

  http_tcp_listeners = [
    {
      port               = "${var.listener_port}"
      protocol           = "HTTP"
      target_group_index = 0
    }
  ]

  tags = {
    Environment = "Test"
  }
}

