data "aws_caller_identity" "current" {}

# Create KMS key for SSM session encryption
resource "aws_kms_key" "ssm_kms_key" {
  description             = "KMS key for SSM session encryption"
  deletion_window_in_days = 7
  enable_key_rotation     = true
  policy                  = data.aws_iam_policy_document.ssm_kms_key_policy.json

  tags = merge(
    var.config.tags,
    {
      Name = "ssm-session-kms-key"
    }
  )
}

resource "aws_kms_alias" "ssm_kms_alias" {
  name          = "alias/ssm-session-key"
  target_key_id = aws_kms_key.ssm_kms_key.key_id
}

# KMS key policy
data "aws_iam_policy_document" "ssm_kms_key_policy" {
  statement {
    sid    = "Enable IAM User Permissions"
    effect = "Allow"
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"]
    }
    actions   = ["kms:*"]
    resources = ["*"]
  }

  statement {
    sid    = "Allow CloudWatch to use the key"
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["logs.${var.config.aws_region}.amazonaws.com"]
    }
    actions = [
      "kms:Encrypt*",
      "kms:Decrypt*",
      "kms:ReEncrypt*",
      "kms:GenerateDataKey*",
      "kms:Describe*"
    ]
    resources = ["*"]
  }

  statement {
    sid    = "Allow SSM to use the key"
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["ssm.amazonaws.com"]
    }
    actions = [
      "kms:Encrypt*",
      "kms:Decrypt*",
      "kms:ReEncrypt*",
      "kms:GenerateDataKey*",
      "kms:Describe*"
    ]
    resources = ["*"]
  }
}

# Configure default SSM session encryption
resource "aws_ssm_parameter" "session_encryption" {
  name        = "/SSM/DefaultEncryption"
  description = "Default KMS key for SSM session encryption"
  type        = "String"
  value       = aws_kms_key.ssm_kms_key.arn
  
  tags = var.config.tags
}