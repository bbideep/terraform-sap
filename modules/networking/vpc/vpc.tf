##################################################################################
# VPC Creation
##################################################################################
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  instance_tenancy     = "default"
  enable_dns_hostnames = "true"
  tags                 = var.env_tags
}

output "vpc_id" {
  value = aws_vpc.main.id
}

output "dflt_rtb_id" {
  value = aws_vpc.main.default_route_table_id
}

