resource "aws_api_gateway_stage" "stages" {
  deployment_id = aws_api_gateway_deployment.deployment.id
  rest_api_id   = aws_api_gateway_rest_api.microservice_api.id
  stage_name    = var.stage_name
  description   = "Production Environment"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_wafv2_web_acl_association" "api_gateway_waf_association" {
  resource_arn = aws_api_gateway_stage.stages.arn
  web_acl_arn  = var.waf_arn
}