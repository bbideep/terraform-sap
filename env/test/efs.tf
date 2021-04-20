/*
module "create_efs" {
  source      = "../../modules/storage/efs/creation"
  efs_name    = "qa-efs"
  efs_kms_key = module.kms_cmk_ebs.cmk_arn
  env_tags    = merge(map("Name", "${local.resource_prefix}-efs"), var.env_tags)
}

module "create_efs_mount_target" {
  source = "../../modules/storage/efs/mount_target"
  efs_id = module.create_efs.efs_id
  efs_sg = [module.core_sg.sg_group_id]
  subnet_ids = flatten([
    for key in keys(local.db_subnets) : [
      module.db_subnets[key].subnet_id
    ]
  ])
}
*/