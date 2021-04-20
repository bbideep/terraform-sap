##################################################################################
# Default Route Table Creation
##################################################################################
resource "aws_default_route_table" "default_rtb" {
  #  vpc_id = var.vpc_id
  default_route_table_id = var.dflt_rtb_id

  dynamic "route" {
    for_each = [for rule_obj in var.rt_rules : {
      cidr               = rule_obj.cidr
      dest_endpoint_type = rule_obj.dest_endpoint
      dest_endpoint_id   = rule_obj.dest_id
      desc               = rule_obj.desc
      }
    ]
    content {
      cidr_block     = route.value["cidr"]
      nat_gateway_id = route.value["dest_endpoint_type"] == "nat_gateway" ? route.value["dest_endpoint_id"] : null
      gateway_id     = route.value["dest_endpoint_type"] == "vpn_gateway" ? route.value["dest_endpoint_id"] : null
    }
  }
  tags = var.env_tags

}

output "rtb_id" {
  value = aws_default_route_table.default_rtb.id
}
