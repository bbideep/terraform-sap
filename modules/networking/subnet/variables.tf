variable "vpc_id" {}
variable "subnet_cidr" {}
variable "subnet_name" {}
variable "az_name" {}
variable "env_tags" {
  type = map(any)
}