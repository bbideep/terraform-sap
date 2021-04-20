##################################################################################
# IGW Creation                                                                   #
##################################################################################
resource "aws_internet_gateway" "igw_gateway" {
  vpc_id = var.vpc_id
  tags   = var.env_tags
}

output "id" {
  value = aws_internet_gateway.igw_gateway.id
}
