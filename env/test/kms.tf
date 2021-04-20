##################################################################################
# KMS CMK                                                                        #
##################################################################################

data "aws_caller_identity" "current" {}

## *** TODO: Below Key policy needs to be updated accordingly ***
data "aws_iam_policy_document" "cmk_key_policy" {
  statement {
    sid    = "1"
    effect = "Allow"
    principals {
      type = "AWS"
      identifiers = [
        "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root",
      ]
    }
    actions = [
      "kms:*",
    ]
    resources = [
      "*",
    ]
  }
}

module "kms_cmk_s3" {
  source                  = "../../modules/security/kms"
  alias_name              = "${local.resource_prefix}_s3"
  description             = "Key to encrypt and decrypt S3 objects"
  deletion_window_in_days = 7
  key_policy              = data.aws_iam_policy_document.cmk_key_policy.json
  env_tags                = merge(map("Name", "${local.resource_prefix}-s3-cmk"), var.env_tags)
}

module "kms_cmk_ebs" {
  source                  = "../../modules/security/kms"
  alias_name              = "${local.resource_prefix}_ebs"
  description             = "Key to encrypt and decrypt EBS volume"
  deletion_window_in_days = 7
  key_policy              = data.aws_iam_policy_document.cmk_key_policy.json
  env_tags                = merge(map("Name", "${local.resource_prefix}-ebs-cmk"), var.env_tags)
}