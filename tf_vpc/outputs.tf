# VPC
output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc.vpc_id
}

# CIDR blocks
output "vpc_cidr_block" {
  description = "The CIDR block of the VPC"
  value       = module.vpc.vpc_cidr_block
}

# Subnets
output "private_subnets" {
  description = "List of IDs of private subnets"
  value       = module.vpc.private_subnets
}

output "public_subnets" {
  description = "List of IDs of public subnets"
  value       = module.vpc.public_subnets
}

output "database_subnets" {
  description = "List of IDs of public subnets"
  value       = module.vpc.database_subnets
}

output "database_security_group_id" {
  description = "The ID of the security group"
  value       = module.complete_sg.security_group_id
}

output "server_security_group_id" {
  description = "The ID of the security group"
  value       = module.main_sg.security_group_id
}

