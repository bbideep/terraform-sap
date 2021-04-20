##################################################################################
# NACL Creation                                                                  #
##################################################################################
resource "aws_network_acl" "default" {
  vpc_id     = var.vpc_id
  tags       = var.env_tags
  subnet_ids = var.subnet_ids
  dynamic "egress" {
    for_each = [for rule_obj in var.egress_rules : {
      proto      = rule_obj.proto
      from_port  = rule_obj.from_port
      to_port    = rule_obj.to_port
      rule_no    = rule_obj.rule_num
      cidr_block = rule_obj.cidr
    }]
    content {
      protocol   = egress.value["proto"]
      rule_no    = egress.value["rule_no"]
      action     = "allow"
      cidr_block = egress.value["cidr_block"]
      from_port  = egress.value["from_port"]
      to_port    = egress.value["to_port"]
    }
  }

  dynamic "ingress" {
    for_each = [for rule_obj in var.ingress_rules : {
      proto      = rule_obj.proto
      from_port  = rule_obj.from_port
      to_port    = rule_obj.to_port
      rule_no    = rule_obj.rule_num
      cidr_block = rule_obj.cidr
    }]
    content {
      protocol   = ingress.value["proto"]
      rule_no    = ingress.value["rule_no"]
      action     = "allow"
      cidr_block = ingress.value["cidr_block"]
      from_port  = ingress.value["from_port"]
      to_port    = ingress.value["to_port"]
    }
  }
}

output "nacl_id" {
  value = aws_network_acl.default.id
}



