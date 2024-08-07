# State management for VPC Link
terraform {
  backend "s3" {
    bucket         = "my-state-management"
    key            = "vpc_link/terraform.tfstate"
    region         = "us-east-1"
    #dynamodb_table = "terraform-lock-table"
    #encrypt        = true
  }
}

# Data source for the Network Load Balancer
data "aws_lb" "eld_nlb"{
  name = var.nlb_name
}

# VPC Private link to attach NLB with API Gateway
resource "aws_api_gateway_vpc_link" "eld_vpc_link" {
  name        = var.vpc_link_name
  description = var.vpc_link_description
  target_arns = [data.aws_lb.eld_nlb.arn]
  tags = merge(
    {
      "Environment"   = var.env
    }
    , var.tags)
}
