# VPC
output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc.vpc_id
}

output "database_security_group_id" {
  description = "The ID of the security group"
  value       = module.complete_sg.security_group_id
}

output "database_subnet_group_name" {
  description = "Name of database subnet group"
  value	      = module.vpc.database_subnet_group_name
}
