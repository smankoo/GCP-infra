variable "access_key" {}
variable "secret_key" {}
variable "region" {
  default = "us-east-1"
}
variable "admin_password" {}
variable "default_windows_ami_id" {}

variable "default_key" {}

variable "default_az" {
  default = "us-east-1a"
}

variable "domain_name" {
  default = "SINGH.local"
}
variable "domain_user" {
  default = "sumeet"
}

variable "domain_pass"{}

variable "vpc_cidr" {}
variable "subnet1_cidr" {}
