##################################################################################
# Security Group Creation                                                                #
##################################################################################
resource "aws_security_group" "sg_group" {
  name   = var.sg_name
  tags   = var.env_tags
  vpc_id = var.vpc_id
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  dynamic "ingress" {
    for_each = [for rule_obj in var.sg_rules : {
      proto   = rule_obj.proto
      fport   = rule_obj.from_port
      tport   = rule_obj.to_port
      cidr    = rule_obj.cidr
      secgrps = rule_obj.security_groups
      desc    = rule_obj.desc
      }
    ]
    content {
      from_port = ingress.value["fport"]
      to_port   = ingress.value["tport"]
      protocol  = ingress.value["proto"]
      #cidr_blocks = [ingress.value["cidr"]]
      cidr_blocks     = length(ingress.value["cidr"]) > 0 ? [ingress.value["cidr"]] : null
      security_groups = length(ingress.value["secgrps"]) > 0 ? [ingress.value["secgrps"]] : null
      description     = ingress.value["desc"]
    }
  }
}

output "sg_group_id" {
  value = aws_security_group.sg_group.id
}
