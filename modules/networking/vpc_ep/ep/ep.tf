resource "aws_vpc_endpoint" "end_point" {
  vpc_id              = var.vpc_id
  service_name        = var.tgt_endpoint
  vpc_endpoint_type   = var.endpoint_type
  security_group_ids  = var.sg_ids
  subnet_ids          = var.snet_ids
  private_dns_enabled = var.enable_pvt_dns
  tags                = var.env_tags
}

output "end_point_id" {
  value = aws_vpc_endpoint.end_point.id
}

