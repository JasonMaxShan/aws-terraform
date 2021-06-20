provider "aws" {
  region = local.region
}

locals {
  name   = "${var.db_instance_name}"
  region = "${var.region}"
  tags = {
    Owner       = "user"
    Environment = "dev"
  }

  engine                = "mysql"
  engine_version        = "8.0.20"
  family                = "mysql8.0" # DB parameter group
  major_engine_version  = "8.0"      # DB option group
  instance_class        = "${var.instance_class}"
  allocated_storage     = 20
  max_allocated_storage = 100
  port                  = 3306
}


################################################################################
# Master DB
################################################################################

module "master" {
  source = "../terraform-aws-modules/terraform-aws-rds"

  identifier = "${local.name}-master"

  engine               = local.engine
  engine_version       = local.engine_version
  family               = local.family
  major_engine_version = local.major_engine_version
  instance_class       = local.instance_class

  allocated_storage     = local.allocated_storage
  max_allocated_storage = local.max_allocated_storage
  storage_encrypted     = false

  name     = "${var.dbname}"
  username = "${var.username}"
  password = "${var.password}"
  port     = local.port

  multi_az               = true
  create_db_subnet_group = false
  db_subnet_group_name   = "${var.db_subnet_group_name}"
  vpc_security_group_ids = "${var.vpc_security_group_ids}"

  maintenance_window              = "Mon:00:00-Mon:03:00"
  backup_window                   = "03:00-06:00"
  enabled_cloudwatch_logs_exports = ["general"]

  # Backups are required in order to create a replica
  backup_retention_period = 1
  skip_final_snapshot     = true
  deletion_protection     = false

  tags = local.tags
}

################################################################################
# Replica DB
################################################################################

module "replica" {
  source = "../terraform-aws-modules/terraform-aws-rds"

  identifier = "${local.name}-replica"

  # Source database. For cross-region use db_instance_arn
  replicate_source_db = module.master.db_instance_id

  engine               = local.engine
  engine_version       = local.engine_version
  family               = local.family
  major_engine_version = local.major_engine_version
  instance_class       = local.instance_class

  allocated_storage     = local.allocated_storage
  max_allocated_storage = local.max_allocated_storage
  storage_encrypted     = false

  # Username and password should not be set for replicas
  username = null
  password = null
  port     = local.port

  multi_az               = false
  vpc_security_group_ids = "${var.vpc_security_group_ids}"

  maintenance_window              = "Tue:00:00-Tue:03:00"
  backup_window                   = "03:00-06:00"
  enabled_cloudwatch_logs_exports = ["general"]

  backup_retention_period = 0
  skip_final_snapshot     = true
  deletion_protection     = false

  # Not allowed to specify a subnet group for replicas in the same region
  create_db_subnet_group = false

  tags = local.tags
}
