provider "aws" {
  region = local.region
}
######################################################################
locals {
  region = "${var.region}"
}
######################################################################
module "vpc" {
  source = "../terraform-aws-modules/terraform-aws-vpc"

  name = "${var.vpc_name}"
  cidr = "${var.cidr}"

  azs             = "${var.azs}"
  private_subnets = "${var.private_subnets}"
  public_subnets  = "${var.public_subnets}"
  database_subnets = "${var.database_subnets}"

  enable_nat_gateway = true
  

  tags = {
    Terraform = "true"
    Environment = "dev"
  }
}

module "main_sg" {
  source = "../terraform-aws-modules/terraform-aws-security-group"

  name        = "SG-server"
  description = "Security group for server"
  vpc_id      = module.vpc.vpc_id
  use_name_prefix = false
  ingress_with_cidr_blocks = [
    {
      rule        = "ssh-tcp"
      cidr_blocks = "0.0.0.0/0"
    },
    {
      rule        = "http-80-tcp"
      cidr_blocks = "0.0.0.0/0"
    }
  ]
  egress_with_cidr_blocks = [
    {
      rule        = "all-all"
      cidr_blocks = "0.0.0.0/0"
    }
  ]
}
module "complete_sg" {
  source = "../terraform-aws-modules/terraform-aws-security-group"

  name        = "SG-database"
  description = "Security group for database"
  vpc_id      = module.vpc.vpc_id
  use_name_prefix = false
  ingress_with_source_security_group_id = [
    {
      rule                     = "mysql-tcp"
      source_security_group_id = module.main_sg.security_group_id
    },
    {
      rule                     = "mongodb-27017-tcp"
      source_security_group_id = module.main_sg.security_group_id
    },
    {
      rule                     = "postgresql-tcp"
      source_security_group_id = module.main_sg.security_group_id
    }]
  egress_with_cidr_blocks = [
    {
      rule        = "all-all"
      cidr_blocks = "0.0.0.0/0"
    }
  ]
}
