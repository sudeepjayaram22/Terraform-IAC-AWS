#Output of API gateway
output "api_key_source" {
  value = aws_api_gateway_rest_api.microservice_api.api_key_source
}

output "arn_of_api_gateway" {
  value = aws_api_gateway_rest_api.microservice_api.arn
}

output "binary_media_types" {
  value = aws_api_gateway_rest_api.microservice_api.binary_media_types
}

output "created_date" {
  value = aws_api_gateway_rest_api.microservice_api.created_date
}

output "description" {
  value = aws_api_gateway_rest_api.microservice_api.description
}

output "disable_execute_api_endpoint" {
  value = aws_api_gateway_rest_api.microservice_api.disable_execute_api_endpoint
}

output "execution_arn" {
  value = aws_api_gateway_rest_api.microservice_api.execution_arn
}

output "api_gateway_id" {
  value = aws_api_gateway_rest_api.microservice_api.id
}

output "minimum_compression_size" {
  value = aws_api_gateway_rest_api.microservice_api.minimum_compression_size
}

output "name_of_api_gateway" {
  value = aws_api_gateway_rest_api.microservice_api.name
}

output "policy_of_api_gateway" {
  value = aws_api_gateway_rest_api.microservice_api.policy
}

output "root_resource_id" {
  value = aws_api_gateway_rest_api.microservice_api.root_resource_id
}

output "tags_all" {
  value = aws_api_gateway_rest_api.microservice_api.tags_all
}

# Output the API Gateway URI Deployment
output "deployment_created_date" {
  value = aws_api_gateway_deployment.deployment.created_date
}

output "deployment_execution_arn" {
  value = aws_api_gateway_deployment.deployment.execution_arn
}

output "api_gateway_uri" {
  value = aws_api_gateway_deployment.deployment.invoke_url
}

