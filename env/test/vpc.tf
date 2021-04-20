
##################################################################################
# VPC Creation                                                                   #
##################################################################################

module "qa_vpc" {
  source   = "../../modules/networking/vpc"
  vpc_cidr = local.vpc_cidr
  vpc_name = "${local.resource_prefix}.vpc"
  env_tags = merge(map("Name", "${local.resource_prefix}-vpc"), var.env_tags)
}
