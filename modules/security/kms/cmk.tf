resource "aws_kms_key" "key" {
  description             = var.description
  key_usage               = "ENCRYPT_DECRYPT"
  policy                  = var.key_policy
  deletion_window_in_days = var.deletion_window_in_days
  is_enabled              = true
  enable_key_rotation     = true
  tags                    = var.env_tags
}

resource "aws_kms_alias" "key_alias" {
  name          = "alias/${var.alias_name}"
  target_key_id = aws_kms_key.key.id
}


output "cmk_arn" {
  value = aws_kms_alias.key_alias.arn
}