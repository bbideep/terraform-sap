variable "alias_name" {}
variable "description" {}
variable "deletion_window_in_days" {}
variable "key_policy" {}
variable "env_tags" {
  type = map(any)
}