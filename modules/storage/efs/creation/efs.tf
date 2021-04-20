resource "aws_efs_file_system" "efs" {
  creation_token = var.efs_name
  encrypted      = "true"
  kms_key_id     = var.efs_kms_key
  tags           = var.env_tags
}

output "efs_id" {
  value = aws_efs_file_system.efs.id
}
