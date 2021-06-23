variable "region"{
  default = "us-west-2"
}
variable "name"{
  default = "server-elb"
}
variable "vpc_id"{
  default = "vpc-04e4c6c78150e0de5"
}
variable "subnets"{
  default = ["subnet-05a8264c99a6802d2","subnet-01a776bdb64d99b70"]
}
variable "security_groups"{
  default = ["sg-055f595e0d8ed34c8"]
}
variable "target_group_name"{
  default = "tg-server"
}
variable "tg_port"{
  default = "8080"
}
variable "listener_port"{
  default = "8080"
}
