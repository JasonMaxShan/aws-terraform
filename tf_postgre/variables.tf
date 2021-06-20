variable "region"{
  default = "us-west-2"
}
variable "db_instance_name"{
  default = "postgresql-1"
}
variable "instance_class"{
  default = "db.t3.medium"
}
variable "dbname"{
  default = "unicorn_db"
}
variable "username"{
  default = "postgres"
}
variable "password"{
  default = "unicorndb"
}
variable "db_subnet_group_name"{
  default = "my-vpc"
}
variable "vpc_security_group_ids"{
  default = ["sg-0f810d526d97685db"]
}

