variable "aws_region" {
  description = "The AWS region where resources will be created"
  default = "us-east-1"
}

variable "alb_name" {
  description = "Name of the ALB"
  default = "my-alb"
}

variable "alb_internal" {
  description = "Boolean flag indicating if the ALB is internal (true/false)"
  default = true
}

variable "nlb_name" {
  description = "Name of the NLB"
  default = "my-nlb"
}

variable "nlb_internal" {
  description = "Boolean flag indicating if the NLB is internal (true/false)"
  default = true
}


variable "target_group_name" {
  description = "Name of the target group"
  default = "my-tg"
}

variable "target_group_port" {
  description = "Port on which targets receive traffic from the load balancer"
  default     = 80
}

variable "target_group_protocol" {
  description = "Protocol used for the targets in the target group"
  default     = "TCP"
}

variable "target_group_health_check_path" {
  description = "The destination for the health check request"
  default     = "/"
}

variable "target_group_health_check_port" {
  description = "The port to use to connect with the target for health checking"
  default     = 80
}

variable "target_group_health_check_protocol" {
  description = "The protocol to use for the health check"
  default     = "HTTP"
}

variable "target_group_health_check_interval" {
  description = "The approximate amount of time, in seconds, between health checks of an individual target"
  default     = 30
}

variable "target_group_health_check_timeout" {
  description = "The amount of time, in seconds, during which no response means a failed health check"
  default     = 10
}

variable "target_group_health_check_healthy_threshold" {
  description = "The number of consecutive health checks successes required before considering an unhealthy target healthy"
  default     = 3
}

variable "target_group_health_check_unhealthy_threshold" {
  description = "The number of consecutive health check failures required before considering the target unhealthy"
  default     = 3
}

variable "listener_port" {
  description = "The port on which the listener listens for requests"
  default     = 80
}

variable "listener_protocol" {
  description = "The protocol for the listener"
  default     = "TCP"
}

variable "listener_rule_priority" {
  description = "The priority for the rule"
  default     = 100
}

#variable "listener_rule_host_header" {
#  description = "The host header condition to match for the rule"
#}

variable "alb_security_group_name" {
  description = "Name of the security group for ALB"
  default = "my-secgrp-alb"
}

variable "alb_security_group_description" {
  description = "Description of the security group for ALB"
  default = "my-secgrp-alb-description"
}

variable "alb_sg_ingress_from_port" {
  description = "The start port (inclusive) for the ingress rule"
  default     = 80
}

variable "alb_sg_ingress_to_port" {
  description = "The end port (inclusive) for the ingress rule"
  default     = 80
}

variable "alb_sg_ingress_protocol" {
  description = "The protocol to apply to the ingress rule"
  default     = "tcp"
}

#variable "alb_sg_ingress_cidr_blocks" {
#  description = "List of CIDR blocks to allow inbound traffic from"
#  type        = list(string)
#}

variable "alb_sg_egress_from_port" {
  description = "The start port (inclusive) for the egress rule"
  default     = 0
}

variable "alb_sg_egress_to_port" {
  description = "The end port (inclusive) for the egress rule"
  default     = 0
}

variable "alb_sg_egress_protocol" {
  description = "The protocol to apply to the egress rule"
  default     = "-1"
}

#variable "alb_sg_egress_cidr_blocks" {
#  description = "List of CIDR blocks to allow outbound traffic to"
#  type        = list(string)
#}

#variable "vpc_id" {
#  description = "The ID of the VPC where resources will be created"
#  default = "vpc-01fa132dc4befd45d"
#}

variable "listener_rule_host_header" {
  description = "The host header value for the listener rule"
  type        = string
  default     = "example.com"
}
