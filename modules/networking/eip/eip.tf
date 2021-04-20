
##################################################################################
# EIP Creation                                                                   #
##################################################################################
resource "aws_eip" "default" {
  vpc  = true
  tags = var.env_tags
}

output "id" {
  value = aws_eip.default.id
}