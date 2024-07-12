provider "aws" {
  region = var.aws_region
}

# Import VPC module from networking script
module "aws_vpc" {
  source = "../networking"
								   
										
}


# Create an ALB
resource "aws_lb" "my_alb" {
  name               = var.alb_name
  internal           = var.alb_internal
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = flatten([module.aws_vpc.private_subnets_id])

  tags = {
    Name = var.alb_name
  }
}

# Create a NLB
resource "aws_lb" "my_nlb" {
  name               = var.nlb_name
  internal           = var.nlb_internal
  load_balancer_type = "network"
  subnets            = flatten([module.aws_vpc.private_subnets_id])

  tags = {
    Name = var.nlb_name
  }
}

# Create a target group for NLB
resource "aws_lb_target_group" "my_target_group" {
  name        = var.target_group_name
  port        = var.target_group_port
  protocol    = var.target_group_protocol
  vpc_id      = module.aws_vpc.vpc_id  # Use VPC ID from the networking script

  health_check {
    path                = var.target_group_health_check_path
    port                = var.target_group_health_check_port
    protocol            = var.target_group_health_check_protocol
    interval            = var.target_group_health_check_interval
    timeout             = var.target_group_health_check_timeout
    healthy_threshold   = var.target_group_health_check_healthy_threshold
    unhealthy_threshold = var.target_group_health_check_unhealthy_threshold
  }
}

# Create a listener for NLB
resource "aws_lb_listener" "my_listener" {
  load_balancer_arn = aws_lb.my_nlb.arn
  port              = var.listener_port
  protocol          = var.listener_protocol

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.my_target_group.arn
  }
}


# Define security group for ALB
resource "aws_security_group" "alb_sg" {
  name        = var.alb_security_group_name
  description = var.alb_security_group_description
  vpc_id      = module.aws_vpc.vpc_id  # Use VPC ID from the networking script

  ingress {
    from_port   = var.alb_sg_ingress_from_port
    to_port     = var.alb_sg_ingress_to_port
    protocol    = var.alb_sg_ingress_protocol
    #cidr_blocks = var.alb_sg_ingress_cidr_blocks
  }

  egress {
    from_port   = var.alb_sg_egress_from_port
    to_port     = var.alb_sg_egress_to_port
    protocol    = var.alb_sg_egress_protocol
    #cidr_blocks = var.alb_sg_egress_cidr_blocks
  }
}