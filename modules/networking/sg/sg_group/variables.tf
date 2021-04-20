variable "sg_name" {}
variable "vpc_id" {}
variable "sg_description" {}
variable "env_tags" {
  type = map(any)
}
variable "sg_rules" {
  type = list(any)
}
