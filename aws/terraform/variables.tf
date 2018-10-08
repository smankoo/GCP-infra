variable "access_key" {}
variable "secret_key" {}
variable "region" {
  default = "us-east-1"
}
variable "admin_password" {}
variable "default_windows_ami_id" {}

variable "default_key" {}

variable "domain_name" {
  default = "SINGH.local"
}
variable "domain_user" {
  default = "sumeet"
}

variable "domain_pass"{}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

