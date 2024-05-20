#Create API Gateway domain name , assuming certificate is already defined
# resource "aws_api_gateway_domain_name" "api_gateway_domain" {
#     domain_name = var.domain_name
#     certificate_arn = var.certificate_arn_no
#     security_policy = var.security_policy_value
#     endpoint_configuration {
#       types = ["REGIONAL"]
#     }
# }

# resource "aws_api_gateway_base_path_mapping" "base_path_mapping" {
#     base_path = ""
#     api_id = aws_api_gateway_rest_api.microservice_api.id
#     domain_name = aws_api_gateway_domain_name.api_gateway_domain.domain_name
#     stage_name = aws_api_gateway_deployment.deployment.stage_name
# }  