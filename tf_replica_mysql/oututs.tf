output "db_instance_address" {
  description = "The address of the RDS instance"
  value       = module.master.db_instance_address
}
output "db_name" {
  description = "The database name"
  value       = module.master.db_instance_name
}

output "db_instance_username" {
  description = "The master username for the database"
  value       = module.master.db_instance_username
  sensitive = true
}

output "db_instance_password" {
  description = "The database password (this password may be old, because Terraform doesn't track it after initial creation)"
  value       = module.master.db_instance_password
  sensitive = true
}


