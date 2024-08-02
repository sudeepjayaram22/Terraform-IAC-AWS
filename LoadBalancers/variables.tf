variable "aws_region" {
  description = "The AWS region to create resources in"
  type        = string
  default     = "us-east-1"
}

variable "alb_name" {
  description = "The name of the ALB"
  type        = string
  default     = "my-alb"
}

variable "alb_internal" {
  description = "Whether the ALB is internal or external"
  type        = bool
  default     = true
}

variable "alb_target_group_name" {
  description = "The name of the target group for ALB"
  type        = string
  default     = "my-alb-target-group"
}

variable "cluster_name"{
    description = "Name of the eks cluster to update in the alb tag"
    type = string
    default = "eks-cluster"
}

variable "alb_target_group_port" {
  description = "The port for the ALB target group"
  type        = number
  default     = 80
}

variable "alb_target_group_protocol" {
  description = "The protocol for the ALB target group"
  type        = string
  default     = "HTTP"
}

variable "alb_target_group_health_check_path" {
  description = "The health check path for the ALB target group"
  type        = string
  default     = "/"
}

variable "alb_target_group_health_check_port" {
  description = "The health check port for the ALB target group"
  type        = string
  default     = "traffic-port"
}

variable "alb_target_group_health_check_protocol" {
  description = "The health check protocol for the ALB target group"
  type        = string
  default     = "HTTP"
}

variable "alb_target_group_health_check_interval" {
  description = "The health check interval for the ALB target group"
  type        = number
  default     = 30
}

variable "alb_target_group_health_check_timeout" {
  description = "The health check timeout for the ALB target group"
  type        = number
  default     = 5
}

variable "alb_target_group_health_check_healthy_threshold" {
  description = "The health check healthy threshold for the ALB target group"
  type        = number
  default     = 5
}

variable "alb_target_group_health_check_unhealthy_threshold" {
  description = "The health check unhealthy threshold for the ALB target group"
  type        = number
  default     = 2
}

variable "alb_listener_port" {
  description = "The port for the ALB listener"
  type        = number
  default     = 80
}

variable "alb_listener_protocol" {
  description = "The protocol for the ALB listener"
  type        = string
  default     = "HTTP"
}

variable "nlb_name" {
  description = "The name of the NLB"
  type        = string
  default     = "my-nlb"
}

variable "nlb_internal" {
  description = "Whether the NLB is internal or external"
  type        = bool
  default     = false
}

variable "nlb_target_group_name" {
  description = "The name of the target group for NLB"
  type        = string
  default     = "my-nlb-target-group"
}

variable "nlb_target_group_port" {
  description = "The port for the NLB target group"
  type        = number
  default     = 80
}

variable "nlb_target_group_protocol" {
  description = "The protocol for the NLB target group"
  type        = string
  default     = "TCP"
}

variable "nlb_target_group_health_check_path" {
  description = "The health check path for the NLB target group"
  type        = string
  default     = "/"
}

variable "nlb_target_group_health_check_port" {
  description = "The health check port for the NLB target group"
  type        = string
  default     = "traffic-port"
}

variable "nlb_target_group_health_check_protocol" {
  description = "The health check protocol for the NLB target group"
  type        = string
  default     = "HTTP"
}

variable "nlb_target_group_health_check_interval" {
  description = "The health check interval for the NLB target group"
  type        = number
  default     = 30
}

variable "nlb_target_group_health_check_timeout" {
  description = "The health check timeout for the NLB target group"
  type        = number
  default     = 5
}

variable "nlb_target_group_health_check_healthy_threshold" {
  description = "The health check healthy threshold for the NLB target group"
  type        = number
  default     = 5
}

variable "nlb_target_group_health_check_unhealthy_threshold" {
  description = "The health check unhealthy threshold for the NLB target group"
  type        = number
  default     = 2
}

variable "nlb_listener_port" {
  description = "The port for the NLB listener"
  type        = number
  default     = 80
}

variable "nlb_listener_protocol" {
  description = "The protocol for the NLB listener"
  type        = string
  default     = "TCP"
}

variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
  #default     = module.aws_vpc.vpc_id
  default     = "vpc-0f7d4e18a8076a061"
}

variable "public_subnet_ids" {
  description = "List of public subnet IDs"
  type        = list(string)
  #default     = module.aws_vpc.public_subnet_ids
  default     = ["subnet-0068b3a4192bd1f7c",    "subnet-0d9594b7d0841f515"]
}

variable "private_subnet_ids" {
  description = "List of private subnet IDs"
  type        = list(string)
  default     = ["subnet-06e9231507e2a04ce",    "subnet-0f9f963d467f06416"]

}

variable "alb_security_group_name" {
  description = "Name of the ALB security group"
  type        = string
  default     = "alb-sg"
}

variable "alb_security_group_description" {
  description = "Description of the ALB security group"
  type        = string
  default     = "Security group for ALB"
}

variable "alb_sg_ingress_from_port" {
  description = "Ingress from port for ALB security group"
  type        = number
  default     = 80
}

variable "alb_sg_ingress_to_port" {
  description = "Ingress to port for ALB security group"
  type        = number
  default     = 80
}

variable "alb_sg_ingress_protocol" {
  description = "Ingress protocol for ALB security group"
  type        = string
  default     = "TCP"
}

variable "alb_sg_ingress_cidr_blocks" {
  description = "Ingress CIDR blocks for ALB security group"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "alb_sg_egress_from_port" {
  description = "Egress from port for ALB security group"
  type        = number
  default     = 0
}

variable "alb_sg_egress_to_port" {
  description = "Egress to port for ALB security group"
  type        = number
  default     = 0
}

variable "alb_sg_egress_protocol" {
  description = "Egress protocol for ALB security group"
  type        = string
  default     = "-1"
}

variable "alb_sg_egress_cidr_blocks" {
  description = "Egress CIDR blocks for ALB security group"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}
