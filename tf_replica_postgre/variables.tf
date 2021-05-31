variable "region"{
  default = "us-west-2"
}
variable "db_instance_name"{
  default = "postgresql"
}
variable "instance_class"{
  default = "db.t3.medium"
}
variable "dbname"{
  default = "unicorn_db"
}
variable "username"{
  default = "unicorn"
}
variable "password"{
  default = "12345678"
}
variable "subnet_ids"{
  default = ["subnet-0a3c29d0a9ca2e546",
  "subnet-0c20f61eeb3f6250e",
  "subnet-0b5287fc9888da34e"]
}
variable "vpc_security_group_ids"{
  default = ["sg-0a1e494df47b0d155"]
}

