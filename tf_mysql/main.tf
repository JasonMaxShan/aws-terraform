provider "aws" {
  region = local.region
}
######################################################################
locals {
  region = "${var.region}"
  name   = "${var.db_instance_name}"
  tags = {
    Owner       = "user"
    Environment = "dev"
  }
}
######################################################################
module "db" {
  source = "../terraform-aws-modules/terraform-aws-rds"

  identifier = local.name

  # All available versions: https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_PostgreSQL.html#PostgreSQL.Concepts
  engine                = "mysql"
  engine_version        = "8.0.20"
  family                = "mysql8.0" # DB parameter group
  major_engine_version  = "8.0"      # DB option group
  instance_class       = "${var.instance_class}"

  allocated_storage     = 20
  max_allocated_storage = 100
  storage_encrypted     = false

  # NOTE: Do NOT use 'user' as the value for 'username' as it throws:
  # "Error creating DB Instance: InvalidParameterValue: MasterUsername
  # user cannot be used as it is a reserved word used by the engine"
  name     = "${var.dbname}"
  username = "${var.username}"
  password = "${var.password}"
  port     = 3306

  multi_az               = true
  create_db_subnet_group = false
  db_subnet_group_name   = "${var.db_subnet_group_name}"
  vpc_security_group_ids = "${var.vpc_security_group_ids}"
  maintenance_window              = "Mon:00:00-Mon:03:00"
  backup_window                   = "03:00-06:00"
  enabled_cloudwatch_logs_exports = ["general"]

  backup_retention_period = 0
  skip_final_snapshot     = true
  deletion_protection     = false

  performance_insights_enabled          = true
  performance_insights_retention_period = 7
  create_monitoring_role                = true
  monitoring_interval                   = 60

  parameters = [
    {
      name  = "character_set_client"
      value = "utf8mb4"
    },
    {
      name  = "character_set_server"
      value = "utf8mb4"
    }
  ]

  tags = local.tags
  db_option_group_tags = {
    "Sensitive" = "low"
  }
  db_parameter_group_tags = {
    "Sensitive" = "low"
  }
  db_subnet_group_tags = {
    "Sensitive" = "high"
  }
}
