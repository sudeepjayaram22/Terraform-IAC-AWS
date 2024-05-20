# State management for API Gateway
terraform {
   backend "s3" {
     bucket         = "bucket_name"
     key            = "tfstate"
     encrypt        = true
     region         = "aws_region"
     #dynamodb_table = "terraform-state-locks"
   }
}

data "aws_api_gateway_vpc_link" "vpc_link_connection_id" {
  name = var.vpc_link_name
}

data "aws_lb" "load_balancer_nlb_alb" {
  arn  = var.load_balancer_arn
  name = var.load_balancer_name
}  

# Create an API Gateway 
resource "aws_api_gateway_rest_api" "microservice_api" {
  name        = local.swagger_title
  description = "API Gateway for Microservices"
  body = data.template_file.swagger.rendered
   endpoint_configuration {
    types = ["REGIONAL"]
  }
}

# Load Swagger file
data "template_file" "swagger" {
  template = file(var.swagger_file_path) 
}

# Parse Swagger file to extract resource paths and methods
locals {
  swagger_paths = jsondecode(data.template_file.swagger.rendered)["paths"]
  swagger_title = jsondecode(data.template_file.swagger.rendered).info.title
  path_methods = flatten([for path, methods in local.swagger_paths : [for method, _ in methods : { path = path, method = method }]])
}

locals {
  path_parameters = flatten([for path, methods in local.swagger_paths : [
    for method, details in methods : {
      method = method
      path   = path
      params = lookup(details, "parameters", [])
    }
  ]])
}

# Retrieve the resource IDs from the Swagger file
data "aws_api_gateway_resource" "resources" {
  count       = length(local.path_methods)
  rest_api_id = aws_api_gateway_rest_api.microservice_api.id
  path        = local.path_methods[count.index].path
}

# Iterate through each path and method in Swagger file
resource "aws_api_gateway_integration" "api_integrations" {
  count                   = length(local.path_methods)
  rest_api_id             = aws_api_gateway_rest_api.microservice_api.id
  resource_id             = data.aws_api_gateway_resource.resources[count.index].id
  http_method             = upper(local.path_methods[count.index].method)
  integration_http_method = upper(local.path_methods[count.index].method)
  type                    = "HTTP_PROXY"
  uri                     = "http://${var.vpc_url}:80${local.path_methods[count.index].path}"
  # uri                     = "http://${data.aws_lb.load_balancer_nlb_alb.dns_name}:80${local.path_methods[count.index].path}"
  connection_type         = "VPC_LINK"
  #connection_id           = var.vpc_link_uri   
  #using data source configure api gateway to vpc_link 
  connection_id = data.aws_api_gateway_vpc_link.vpc_link_connection_id.id
  # Setting up request parameters dynamically based on path parameters from json file
  request_parameters = {
    for param in local.path_parameters[count.index].params : 
      # "integration.request.${param.in}.${param.name}" => "method.request.${param.in}.${param.name}"
      "integration.request.path.${param.name}" => "method.request.path.${param.name}"
  }
}

# Create Deployment
resource "aws_api_gateway_deployment" "deployment" {
  depends_on  = [aws_api_gateway_integration.api_integrations] 
  rest_api_id = aws_api_gateway_rest_api.microservice_api.id
 #stage_name  = var.stage_name  # If stage is already defined 
}






