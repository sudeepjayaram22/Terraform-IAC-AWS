terraform {
  backend "s3" {
    bucket         = "my-state-management"
    key            = "LoadBalancers/terraform.tfstate"
    region         = "us-east-1"
    #dynamodb_table = "terraform-lock-table"
    #encrypt        = true
  }
}

provider "aws" {
  region = var.aws_region
}

# Import VPC module from networking script
#module "aws_vpc" {
#  source = "../networking"
#}

# Create an ALB
resource "aws_lb" "my_alb" {
  name               = var.alb_name
  internal           = var.alb_internal
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = var.private_subnet_ids

  tags = {
    Name                       = var.alb_name
    "elbv2.k8s.aws/cluster"    = var.cluster_name
    "ingress.k8s.aws/resource" = "LoadBalancer"
    "ingress.k8s.aws/stack"    = var.alb_target_group_name
  }
}

# Create a NLB
resource "aws_lb" "my_nlb" {
  name               = var.nlb_name
  internal           = var.nlb_internal
  load_balancer_type = "network"
  subnets            = var.private_subnet_ids

  tags = {
    Name = var.nlb_name
  }
}

# Create a target group for NLB
resource "aws_lb_target_group" "nlb_target_group" {
  name     = var.nlb_target_group_name
  port     = var.nlb_target_group_port
  protocol = var.nlb_target_group_protocol
  vpc_id   = var.vpc_id

  health_check {
    path                = var.nlb_target_group_health_check_path
    port                = var.nlb_target_group_health_check_port
    protocol            = var.nlb_target_group_health_check_protocol
    interval            = var.nlb_target_group_health_check_interval
    timeout             = var.nlb_target_group_health_check_timeout
    healthy_threshold   = var.nlb_target_group_health_check_healthy_threshold
    unhealthy_threshold = var.nlb_target_group_health_check_unhealthy_threshold
  }
}

# Create a listener for NLB
resource "aws_lb_listener" "nlb_listener" {
  load_balancer_arn = aws_lb.my_nlb.arn
  port              = var.nlb_listener_port
  protocol          = var.nlb_listener_protocol

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.nlb_target_group.arn
  }
}

# Create a target group for ALB to forward traffic to NLB
resource "aws_lb_target_group" "alb_target_group" {
  name     = var.alb_target_group_name
  port     = var.alb_target_group_port
  protocol = var.alb_target_group_protocol
  vpc_id   = var.vpc_id

  health_check {
    path                = var.alb_target_group_health_check_path
    port                = var.alb_target_group_health_check_port
    protocol            = var.alb_target_group_health_check_protocol
    interval            = var.alb_target_group_health_check_interval
    timeout             = var.alb_target_group_health_check_timeout
    healthy_threshold   = var.alb_target_group_health_check_healthy_threshold
    unhealthy_threshold = var.alb_target_group_health_check_unhealthy_threshold
  }
}

# Create a listener for ALB to forward traffic to ALB target group
resource "aws_lb_listener" "alb_listener" {
  load_balancer_arn = aws_lb.my_alb.arn
  port              = var.alb_listener_port
  protocol          = var.alb_listener_protocol

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb_target_group.arn
  }
}

# Security group for ALB
resource "aws_security_group" "alb_sg" {
  name        = var.alb_security_group_name
  description = var.alb_security_group_description
  vpc_id      = var.vpc_id

  ingress {
    from_port   = var.alb_sg_ingress_from_port
    to_port     = var.alb_sg_ingress_to_port
    protocol    = var.alb_sg_ingress_protocol
    cidr_blocks = var.alb_sg_ingress_cidr_blocks
  }

  egress {
    from_port   = var.alb_sg_egress_from_port
    to_port     = var.alb_sg_egress_to_port
    protocol    = var.alb_sg_egress_protocol
    cidr_blocks = var.alb_sg_egress_cidr_blocks
  }
}
