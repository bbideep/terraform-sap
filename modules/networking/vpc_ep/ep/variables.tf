variable "vpc_id" {}
variable "tgt_endpoint" {}
variable "sg_ids" {}
variable "snet_ids" {}
variable "endpoint_type" {}
variable "enable_pvt_dns" {}
variable "env_tags" {
  type = map(any)
}
