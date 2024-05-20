# State management for VPC Link
#terraform {
#   backend "s3" {
#     bucket         = "bucket_name"
#     key            = "tfstate"
#     encrypt        = true
#     region         = "aws_region"
#     #dynamodb_table = "terraform-state-locks"
#   }
#}

# Data source for state management for NLB
#data "terraform_remote_state" "main_module" {
#  backend = "s3"
#  config  = {
#     bucket         = "myappstatemanagement"
#     key            = "dev/nlb/terraform.tfstate"
#     encrypt        = true
#     region         = "us-east-2"
#     #dynamodb_table = "terraform-state-locks"
#   }
#}

# Data source for the Network Load Balancer
data "aws_lb" "new_nlb"{
  name = var.nlb_name
}

# VPC Private link to attach NLB with API Gateway
resource "aws_api_gateway_vpc_link" "new_vpc_link" {
  name        = var.vpc_link_name
  description = var.vpc_link_description
  target_arns = [data.aws_lb.new_nlb.arn]
  tags = merge(
    {
      "Environment"   = var.env
    }
    , var.new_tags)
}
