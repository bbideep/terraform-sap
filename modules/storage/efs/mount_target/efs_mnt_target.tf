resource "aws_efs_mount_target" "efsmnttarget" {
  file_system_id  = var.efs_id
  security_groups = var.efs_sg
  count           = length(var.subnet_ids)
  subnet_id       = element(var.subnet_ids, count.index)

}

output "efs_mnt_target_id" {
  value = aws_efs_mount_target.efsmnttarget.*.id
}
