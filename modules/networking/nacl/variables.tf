variable "vpc_id" {}

variable "subnet_ids" {
  type = list(any)
}
variable "env_tags" {
  type = map(any)
}
variable "ingress_rules" {
  type = list(any)
}
variable "egress_rules" {
  type = list(any)
}
