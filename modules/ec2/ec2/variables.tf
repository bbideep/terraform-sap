variable "ami_id" {}
variable "inst_type" {}
variable "key_name" {}
variable "sec_grp_ids" {
  type = list(string)
}
variable "subnet_id" {}
variable "kms_key_id" {}
variable "disk_spec" {
  type = list(string)
}
variable "root_size" {}
variable "root_type" {}
variable "iam_instance_profile" {}
variable "user_data" {}
variable "enable_detailed_monitoring" {
  type    = bool
  default = true
}
variable "env_tags" {
  type = map(any)
}

