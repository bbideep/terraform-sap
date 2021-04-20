
##################################################################################
# SAPRouter Subnet Creation                                                      #
##################################################################################
module "saprouter_subnets" {
  for_each    = local.saprouter_subnets
  source      = "../../modules/networking/subnet"
  vpc_id      = local.vpc_id
  az_name     = each.value.az
  subnet_cidr = each.value.cidr
  subnet_name = "${local.resource_prefix}-saprouter-subnet-${each.value.az_name}"
  env_tags    = merge(map("Name", "${local.resource_prefix}-saprouter-subnet-${each.value.az_name}"), var.env_tags)
}

##################################################################################
# Public Subnet Creation                                                         #
##################################################################################
module "public_subnets" {
  for_each    = local.public_subnets
  source      = "../../modules/networking/subnet"
  vpc_id      = local.vpc_id
  az_name     = each.value.az
  subnet_cidr = each.value.cidr
  subnet_name = "${local.resource_prefix}-public-subnet-${each.value.az_name}"
  env_tags    = merge(map("Name", "${local.resource_prefix}-public-subnet-${each.value.az_name}"), var.env_tags)
}

##################################################################################
# Admin Private Subnet Creation                                                  #
##################################################################################
module "admin_subnets" {
  for_each    = local.admin_subnets
  source      = "../../modules/networking/subnet"
  vpc_id      = local.vpc_id
  az_name     = each.value.az
  subnet_cidr = each.value.cidr
  subnet_name = "${local.resource_prefix}-admin-subnet-${each.value.az_name}"
  env_tags    = merge(map("Name", "${local.resource_prefix}-admin-subnet-${each.value.az_name}"), var.env_tags)
}

##################################################################################
# Application Private Subnet Creation                                            #
##################################################################################
module "app_subnets" {
  for_each    = local.app_subnets
  source      = "../../modules/networking/subnet"
  vpc_id      = local.vpc_id
  az_name     = each.value.az
  subnet_cidr = each.value.cidr
  subnet_name = "${local.resource_prefix}-app-subnet-${each.value.az_name}"
  env_tags    = merge(map("Name", "${local.resource_prefix}-app-subnet-${each.value.az_name}"), var.env_tags)
}

##################################################################################
# DB Private Subnet Creation                                                     #
##################################################################################
module "db_subnets" {
  for_each    = local.db_subnets
  source      = "../../modules/networking/subnet"
  vpc_id      = local.vpc_id
  az_name     = each.value.az
  subnet_cidr = each.value.cidr
  subnet_name = "${local.resource_prefix}-db-subnet-${each.value.az_name}"
  env_tags    = merge(map("Name", "${local.resource_prefix}-db-subnet-${each.value.az_name}"), var.env_tags)
}