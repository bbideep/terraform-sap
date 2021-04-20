resource "aws_instance" "ec2_instance" {
  ami                         = var.ami_id
  instance_type               = var.inst_type
  key_name                    = var.key_name
  vpc_security_group_ids      = var.sec_grp_ids
  subnet_id                   = var.subnet_id
  associate_public_ip_address = "false"
  #disable_api_termination = true
  iam_instance_profile = var.iam_instance_profile
  monitoring           = var.enable_detailed_monitoring
  root_block_device {
    volume_type = var.root_type
    volume_size = var.root_size
    encrypted   = true
    kms_key_id  = var.kms_key_id
  }
  dynamic "ebs_block_device" {
    for_each = [for rule_obj in var.disk_spec : {
      vol_name = rule_obj.vol_name
      vol_type = rule_obj.vol_type
      vol_size = rule_obj.vol_size
    }]
    content {
      device_name           = ebs_block_device.value["vol_name"]
      volume_type           = ebs_block_device.value["vol_type"]
      volume_size           = ebs_block_device.value["vol_size"]
      delete_on_termination = true
      encrypted             = true
      kms_key_id            = var.kms_key_id
    }
  }
  #user_data 
  tags = var.env_tags
}

output "id" {
  value = aws_internet_gateway.igw_gateway.id
}
