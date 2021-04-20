resource "aws_key_pair" "main" {
  key_name   = var.key_name
  public_key = var.public_key
  tags       = var.env_tags
}

output "key_pair_id" {
  value = aws_key_pair.main.id
}
output "key_pair_arn" {
  value = aws_key_pair.main.arn
}