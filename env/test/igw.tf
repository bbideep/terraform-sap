
##################################################################################
# Internet Gateway Creation                                                      #
##################################################################################
module "qa_igw" {
  source   = "../../modules/networking/igw"
  vpc_id   = local.vpc_id
  env_tags = merge(map("Name", "${local.resource_prefix}-igw"), var.env_tags)
}