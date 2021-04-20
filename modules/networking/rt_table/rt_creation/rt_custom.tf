##################################################################################
# Route Table Creation
##################################################################################
resource "aws_route_table" "custom_rtb" {
  vpc_id = var.vpc_id

  dynamic "route" {
    for_each = [for rule_obj in var.rt_rules : {
      cidr               = rule_obj.cidr
      dest_endpoint_type = rule_obj.dest_endpoint
      dest_endpoint_id   = rule_obj.dest_id
      }
    ]
    content {
      cidr_block           = route.value["cidr"]
      nat_gateway_id       = route.value["dest_endpoint_type"] == "nat_gateway" ? route.value["dest_endpoint_id"] : null
      gateway_id           = route.value["dest_endpoint_type"] == "vpn_gateway" ? route.value["dest_endpoint_id"] : null
      network_interface_id = route.value["dest_endpoint_type"] == "nw_interface" ? route.value["dest_endpoint_id"] : null
    }
  }
  tags = var.env_tags

}

output "rtb_id" {
  value = aws_route_table.custom_rtb.id
}
