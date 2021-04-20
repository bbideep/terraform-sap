locals {
  default_rt_rules = [
  ]
  nat_gw_pub1_rt_rules = [
    { cidr : local.all_ips, dest_endpoint : "vpn_gateway", dest_id : module.qa_igw.id }
  ]
  sap_router_pub2_rt_rules = [
    { cidr : local.all_ips, dest_endpoint : "vpn_gateway", dest_id : module.qa_igw.id }
  ]
  sap_app_pvt_rt_rules = [
    { cidr : local.all_ips, dest_endpoint : "nat_gateway", dest_id : module.qa_natgw[0].id },
    { cidr : local.all_ips, dest_endpoint : "nat_gateway", dest_id : module.qa_natgw[1].id }
  ]
  sap_adm_pvt_rt_rules = [
    { cidr : local.all_ips, dest_endpoint : "nat_gateway", dest_id : module.qa_natgw[0].id },
    { cidr : local.all_ips, dest_endpoint : "nat_gateway", dest_id : module.qa_natgw[1].id }
  ]
  sap_db_pvt_rt_rules = [
  ]
}

module "default_vpc_rtb" {
  source = "../../modules/networking/rt_table/default_rt_creation"
  #  vpc_id = module.qa_vpc.vpc_id
  #dflt_rtb_id = module.qa_vpc.dflt_rtb_id
  dflt_rtb_id = local.default_rtb_id
  rt_rules    = local.default_rt_rules
  env_tags    = merge(map("Name", "${local.resource_prefix}-default-rtb"), var.env_tags)
}

module "nat_gw_pub1_rtb" {
  source   = "../../modules/networking/rt_table/rt_creation"
  vpc_id   = local.vpc_id
  rt_rules = local.nat_gw_pub1_rt_rules
  env_tags = merge(map("Name", "${local.resource_prefix}-natgw-pub-rtb"), var.env_tags)
}

module "sap_router_pub2_rtb" {
  source   = "../../modules/networking/rt_table/rt_creation"
  vpc_id   = local.vpc_id
  rt_rules = local.sap_router_pub2_rt_rules
  env_tags = merge(map("Name", "${local.resource_prefix}-saprouter-pub-rtb"), var.env_tags)
}

module "sap_app_pvt_rtb" {
  count    = length(local.sap_app_pvt_rt_rules)
  source   = "../../modules/networking/rt_table/rt_creation"
  vpc_id   = local.vpc_id
  rt_rules = [element(local.sap_app_pvt_rt_rules, count.index)]
  env_tags = merge(map("Name", "${local.resource_prefix}-app-pvt-rtb"), var.env_tags)
}

module "sap_adm_pvt_rtb" {
  count    = length(local.sap_adm_pvt_rt_rules)
  source   = "../../modules/networking/rt_table/rt_creation"
  vpc_id   = local.vpc_id
  rt_rules = [element(local.sap_adm_pvt_rt_rules, count.index)]
  env_tags = merge(map("Name", "${local.resource_prefix}-admin-pvt-rtb"), var.env_tags)
}

module "sap_db_pvt_rtb" {
  source   = "../../modules/networking/rt_table/rt_creation"
  vpc_id   = local.vpc_id
  rt_rules = local.sap_db_pvt_rt_rules
  env_tags = merge(map("Name", "${local.resource_prefix}-db-pvt-rtb"), var.env_tags)
}

module "nat_gw_subnet_rt_assignment" {
  source  = "../../modules/networking/rt_table/rt_associate"
  rtb_id  = module.nat_gw_pub1_rtb.rtb_id
  vpgw_id = local.vpgw_id
  subnet_ids = flatten([
    for key in keys(local.public_subnets) : [
      module.public_subnets[key].subnet_id
    ]
  ])
}

module "sap_router_subnet_rt_assignment" {
  source  = "../../modules/networking/rt_table/rt_associate"
  rtb_id  = module.sap_router_pub2_rtb.rtb_id
  vpgw_id = local.vpgw_id
  subnet_ids = flatten([
    for key in keys(local.saprouter_subnets) : [
      module.saprouter_subnets[key].subnet_id
    ]
  ])
}

module "app_subnet_rt_assignment" {
  count                    = length(module.sap_app_pvt_rtb)
  source                   = "../../modules/networking/rt_table/rt_associate"
  rtb_id                   = module.sap_app_pvt_rtb[count.index].rtb_id
  vpgw_id                  = local.vpgw_id
  enable_route_propagation = true
  subnet_ids = flatten([
    module.app_subnets[count.index].subnet_id
  ])
}

module "admin_subnet_rt_assignment" {
  count                    = length(module.sap_adm_pvt_rtb)
  source                   = "../../modules/networking/rt_table/rt_associate"
  rtb_id                   = module.sap_adm_pvt_rtb[count.index].rtb_id
  vpgw_id                  = local.vpgw_id
  enable_route_propagation = true
  subnet_ids = flatten([
    module.admin_subnets[count.index].subnet_id
  ])
}

module "sap_db_subnet_rt_assignment" {
  source  = "../../modules/networking/rt_table/rt_associate"
  rtb_id  = module.sap_db_pvt_rtb.rtb_id
  vpgw_id = local.vpgw_id
  subnet_ids = flatten([
    for key in keys(local.db_subnets) : [
      module.db_subnets[key].subnet_id
    ]
  ])
}
