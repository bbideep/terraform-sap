##################################################################################
# Route Table Association
##################################################################################
resource "aws_route_table_association" "associate_subnet" {
  count          = length(var.subnet_ids)
  subnet_id      = element(var.subnet_ids, count.index)
  route_table_id = var.rtb_id
}

resource "aws_vpn_gateway_route_propagation" "default" {
  vpn_gateway_id = var.vpgw_id
  route_table_id = var.rtb_id
  count          = var.enable_route_propagation ? 1 : 0
}