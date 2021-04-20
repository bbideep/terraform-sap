##################################################################################
# Subnet Creation                                                                #
##################################################################################
resource "aws_subnet" "main" {
  vpc_id            = var.vpc_id
  availability_zone = var.az_name
  cidr_block        = var.subnet_cidr
  tags              = var.env_tags
}

output "subnet_id" {
  value = aws_subnet.main.id
}
