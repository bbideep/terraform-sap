
##################################################################################
# EIP Creation                                                                   #
##################################################################################
module "qa_natgw_eip" {
  count    = length(local.public_subnets)
  source   = "../../modules/networking/eip"
  env_tags = merge(map("Name", "${local.resource_prefix}-eip"), var.env_tags)
}

##################################################################################
# NAT Gateway Creation                                                           #
##################################################################################
module "qa_natgw" {
  count         = length(module.qa_natgw_eip)
  source        = "../../modules/networking/natgw"
  allocation_id = module.qa_natgw_eip[count.index].id
  subnet_id     = module.public_subnets[keys(local.public_subnets)[count.index]].subnet_id
  env_tags      = merge(map("Name", "${local.resource_prefix}-natgw"), var.env_tags)
}
