variable "vpc_id" {}
variable "env_tags" {
  type = map(any)
}
variable "rt_rules" {
  type = list(any)
}
