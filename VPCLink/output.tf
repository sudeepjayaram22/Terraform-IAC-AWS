# Outputs for VPC Link
output "vpc_link_name"{
    value = aws_api_gateway_vpc_link.new_vpc_link.name
}

output "vpc_link_description"{
    value = aws_api_gateway_vpc_link.new_vpc_link.description
}

output "vpc_link_id"{
    value = aws_api_gateway_vpc_link.new_vpc_link.id
}

output "vpc_link_arn"{
    value = aws_api_gateway_vpc_link.new_vpc_link.arn
}

output "vpc_link_target_arns"{
    value = aws_api_gateway_vpc_link.new_vpc_link.target_arns
}

output "vpc_link_tags"{
    value = aws_api_gateway_vpc_link.new_vpc_link.tags_all
}