variable "vpc_name"{
  default = "my-vpc"
}
variable "region"{
  default = "us-west-2"
}
variable "cidr"{
  default = "10.0.0.0/16"
}
variable "azs"{
  default = ["us-west-2a", "us-west-2b"]
}
variable "private_subnets"{
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}
variable "public_subnets"{
  default = ["10.0.101.0/24", "10.0.102.0/24"]
}
variable "database_subnets"{
  default = ["10.0.201.0/24","10.0.202.0/24"]

}
variable "elb_port"{
  default = 8080
}
variable "server_port"{
  default = 8080
}
