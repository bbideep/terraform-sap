##################################################################################
# Public SAPRouter NACL Creation                                                      #
##################################################################################
locals {
  saprouter_ingress_rules = [
    { proto : "tcp", from_port : 3299, to_port : 3299, rule_num : 100, cidr : local.vpc_cidr },
    { proto : "tcp", from_port : 3299, to_port : 3299, rule_num : 110, cidr : local.sap_support_ip },
    ### ADMIN SERVERS IPs NEED TO BE OPENED
    { proto : "tcp", from_port : 22, to_port : 22, rule_num : 120, cidr : local.admin_supernet },
    { proto : "tcp", from_port : 1024, to_port : 65535, rule_num : 130, cidr : local.all_ips }
  ]
  saprouter_egress_rules = [
    { proto : "tcp", from_port : 443, to_port : 443, rule_num : 100, cidr : local.all_ips },
    { proto : "tcp", from_port : 1024, to_port : 65535, rule_num : 110, cidr : local.all_ips }
  ]
}

module "saprouter_nacl" {
  source        = "../../modules/networking/nacl"
  vpc_id        = local.vpc_id
  ingress_rules = local.saprouter_ingress_rules
  egress_rules  = local.saprouter_egress_rules
  env_tags      = merge(map("Name", "${local.resource_prefix}-saprouter-nacl"), var.env_tags)
  /*subnet_ids = [
    module.saprouter_subnets[keys(local.saprouter_subnets)[0]].subnet_id,
    module.saprouter_subnets[keys(local.saprouter_subnets)[1]].subnet_id
  ]*/
  subnet_ids = flatten([
    for key in keys(local.saprouter_subnets) : [
      module.saprouter_subnets[key].subnet_id
    ]
  ])
}

##################################################################################
# Public Nacl Creation                                                           #
##################################################################################
locals {
  public_ingress_rules = [
    { proto : "tcp", from_port : 443, to_port : 443, rule_num : 100, cidr : local.all_ips },
    { proto : "tcp", from_port : 1024, to_port : 65535, rule_num : 110, cidr : local.all_ips }
  ]
  public_egress_rules = [
    { proto : "tcp", from_port : 443, to_port : 443, rule_num : 100, cidr : local.all_ips },
    { proto : "tcp", from_port : 1024, to_port : 65535, rule_num : 110, cidr : local.all_ips }
  ]
}

module "public_nacl" {
  source        = "../../modules/networking/nacl"
  vpc_id        = local.vpc_id
  ingress_rules = local.public_ingress_rules
  egress_rules  = local.public_egress_rules
  env_tags      = merge(map("Name", "${local.resource_prefix}-pub-nacl"), var.env_tags)
  /*subnet_ids = [
    module.public_subnets[keys(local.public_subnets)[0]].subnet_id,
    module.public_subnets[keys(local.public_subnets)[1]].subnet_id
  ]*/
  subnet_ids = flatten([
    for key in keys(local.public_subnets) : [
      module.public_subnets[key].subnet_id
    ]
  ])
}

##################################################################################
# Private App Nacl Creation                                                      #
##################################################################################

locals {
  pvt_app_ingress_rules = [
    #Using the supernet below for admin servers to reduce the number of NACL rules.
    { proto : "tcp", from_port : 22, to_port : 22, rule_num : 100, cidr : local.admin_supernet },
    { proto : "tcp", from_port : 3389, to_port : 3389, rule_num : 110, cidr : local.admin_supernet },
    { proto : "tcp", from_port : 443, to_port : 443, rule_num : 120, cidr : local.internal_cidr },
    { proto : "tcp", from_port : 1024, to_port : 65535, rule_num : 130, cidr : local.internal_cidr },
    { proto : "tcp", from_port : 88, to_port : 88, rule_num : 140, cidr : local.dns_cidr },
    { proto : "udp", from_port : 123, to_port : 123, rule_num : 150, cidr : local.dns_cidr },
    { proto : "tcp", from_port : 135, to_port : 139, rule_num : 160, cidr : local.dns_cidr },
    #{ proto : "tcp", from_port : 139, to_port : 139, rule_num : 170, cidr : local.dns_cidr },
    { proto : "tcp", from_port : 389, to_port : 389, rule_num : 180, cidr : local.dns_cidr },
    { proto : "udp", from_port : 389, to_port : 389, rule_num : 190, cidr : local.dns_cidr },
    { proto : "tcp", from_port : 445, to_port : 445, rule_num : 200, cidr : local.dns_cidr },
    { proto : "tcp", from_port : 464, to_port : 464, rule_num : 210, cidr : local.dns_cidr },
    { proto : "tcp", from_port : 636, to_port : 636, rule_num : 220, cidr : local.dns_cidr },
    { proto : "udp", from_port : 636, to_port : 636, rule_num : 230, cidr : local.dns_cidr },
    { proto : "tcp", from_port : 53, to_port : 53, rule_num : 240, cidr : local.dns_cidr },
    { proto : "udp", from_port : 53, to_port : 53, rule_num : 250, cidr : local.dns_cidr },
    { proto : "tcp", from_port : 3268, to_port : 3269, rule_num : 260, cidr : local.dns_cidr },
    { proto : "tcp", from_port : 49152, to_port : 65535, rule_num : 270, cidr : local.dns_cidr },
    { proto : "udp", from_port : 49152, to_port : 65535, rule_num : 280, cidr : local.dns_cidr },
    { proto : "tcp", from_port : 1024, to_port : 65535, rule_num : 290, cidr : local.vpc_cidr },
    { proto : "tcp", from_port : 443, to_port : 443, rule_num : 300, cidr : local.paymetrics_saas_cidr }
  ]
  pvt_app_egress_rules = [
    { proto : -1, from_port : 0, to_port : 0, rule_num : 100, cidr : local.all_ips }
  ]
}

module "pvt_app_nacl" {
  source        = "../../modules/networking/nacl"
  vpc_id        = local.vpc_id
  ingress_rules = local.pvt_app_ingress_rules
  egress_rules  = local.pvt_app_egress_rules
  env_tags      = merge(map("Name", "${local.resource_prefix}-app-nacl"), var.env_tags)
  /*subnet_ids = [
    module.app_subnets[keys(local.app_subnets)[0]].subnet_id,
    module.app_subnets[keys(local.app_subnets)[1]].subnet_id
  ]*/
  subnet_ids = flatten([
    for key in keys(local.app_subnets) : [
      module.app_subnets[key].subnet_id
    ]
  ])
}

##################################################################################
# Private Admin Nacl Creation                                                    #
##################################################################################

locals {
  pvt_admin_ingress_rules = [
    { proto : "tcp", from_port : 22, to_port : 22, rule_num : 100, cidr : local.vpc_cidr },
    { proto : "tcp", from_port : 3389, to_port : 3389, rule_num : 110, cidr : local.internal_cidr },
    { proto : "tcp", from_port : 443, to_port : 443, rule_num : 120, cidr : local.internal_cidr },
    { proto : "tcp", from_port : 1024, to_port : 65535, rule_num : 130, cidr : local.internal_cidr },
    { proto : "tcp", from_port : 88, to_port : 88, rule_num : 140, cidr : local.dns_cidr },
    { proto : "udp", from_port : 123, to_port : 123, rule_num : 150, cidr : local.dns_cidr },
    { proto : "tcp", from_port : 135, to_port : 135, rule_num : 160, cidr : local.dns_cidr },
    { proto : "tcp", from_port : 139, to_port : 139, rule_num : 170, cidr : local.dns_cidr },
    { proto : "tcp", from_port : 389, to_port : 389, rule_num : 180, cidr : local.dns_cidr },
    { proto : "udp", from_port : 389, to_port : 389, rule_num : 190, cidr : local.dns_cidr },
    { proto : "tcp", from_port : 445, to_port : 445, rule_num : 200, cidr : local.dns_cidr },
    { proto : "tcp", from_port : 464, to_port : 464, rule_num : 210, cidr : local.dns_cidr },
    { proto : "tcp", from_port : 636, to_port : 636, rule_num : 220, cidr : local.dns_cidr },
    { proto : "udp", from_port : 636, to_port : 636, rule_num : 230, cidr : local.dns_cidr },
    { proto : "tcp", from_port : 53, to_port : 53, rule_num : 240, cidr : local.dns_cidr },
    { proto : "udp", from_port : 53, to_port : 53, rule_num : 250, cidr : local.dns_cidr },
    { proto : "tcp", from_port : 3268, to_port : 3269, rule_num : 260, cidr : local.dns_cidr },
    { proto : "tcp", from_port : 49152, to_port : 65535, rule_num : 270, cidr : local.dns_cidr },
    { proto : "udp", from_port : 49152, to_port : 65535, rule_num : 280, cidr : local.dns_cidr },
    { proto : "tcp", from_port : 1024, to_port : 65535, rule_num : 290, cidr : local.vpc_cidr }
  ]
  pvt_admin_egress_rules = [
    { proto : -1, from_port : 0, to_port : 0, rule_num : 100, cidr : local.all_ips }
  ]
}

module "pvt_admin_nacl" {
  source        = "../../modules/networking/nacl"
  vpc_id        = local.vpc_id
  ingress_rules = local.pvt_admin_ingress_rules
  egress_rules  = local.pvt_admin_egress_rules
  env_tags      = merge(map("Name", "${local.resource_prefix}-admin-nacl"), var.env_tags)
  /*subnet_ids = [
    module.admin_subnets[keys(local.admin_subnets)[0]].subnet_id,
    module.admin_subnets[keys(local.admin_subnets)[1]].subnet_id
  ]*/
  subnet_ids = flatten([
    for key in keys(local.admin_subnets) : [
      module.admin_subnets[key].subnet_id
    ]
  ])
}

##################################################################################
# Private DB Nacl Creation                                                       #
##################################################################################

locals {
  db_ingress_rules = [
    { proto : "tcp", from_port : 22, to_port : 22, rule_num : 100, cidr : local.admin_supernet },
    { proto : "tcp", from_port : 3389, to_port : 3389, rule_num : 120, cidr : local.admin_supernet },
    { proto : "tcp", from_port : 32768, to_port : 61000, rule_num : 130, cidr : local.admin_supernet },
    { proto : "tcp", from_port : 1521, to_port : 1521, rule_num : 140, cidr : local.pvt_app_subnet_supernet_cidr },
    { proto : "tcp", from_port : 1433, to_port : 1433, rule_num : 150, cidr : local.pvt_app_subnet_supernet_cidr }
  ]
  db_egress_rules = [
    { proto : -1, from_port : 0, to_port : 0, rule_num : 100, cidr : local.all_ips }
  ]
}

module "db_nacl" {
  source        = "../../modules/networking/nacl"
  vpc_id        = local.vpc_id
  ingress_rules = local.db_ingress_rules
  egress_rules  = local.db_egress_rules
  env_tags      = merge(map("Name", "${local.resource_prefix}-db-nacl"), var.env_tags)
  /*subnet_ids = [
    module.db_subnets[keys(local.db_subnets)[0]].subnet_id,
    module.db_subnets[keys(local.db_subnets)[1]].subnet_id
  ]*/
  subnet_ids = flatten([
    for key in keys(local.db_subnets) : [
      module.db_subnets[key].subnet_id
    ]
  ])
}
