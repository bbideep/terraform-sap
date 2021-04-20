##################################################################################
# NAT GW Creation                                                                #
##################################################################################
resource "aws_nat_gateway" "gw" {
  allocation_id = var.allocation_id
  subnet_id     = var.subnet_id
  tags          = var.env_tags
}

output "id" {
  value = aws_nat_gateway.gw.id
}

#module.public_subnets[keys(local.public_subnets)[0]].subnet_id,
#module.public_subnets[keys(local.public_subnets)[1]].subnet_id
