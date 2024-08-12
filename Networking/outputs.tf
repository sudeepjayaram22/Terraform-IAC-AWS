output "vpc_id" {
  value = aws_vpc.custom_vpc.id
}

output "public_subnets" {
  value = aws_subnet.public_subnets[*].id
}

output "private_subnets" {
  value = aws_subnet.private_subnets[*].id
}

output "security_group_id" {
  value = [for sec in var.security_groups : aws_security_group.sec_groups[sec.name].id]
}
