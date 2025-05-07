# Create IAM role for EC2 instances to use SSM
resource "aws_iam_role" "ssm_instance_role" {
  name = "ManagedInstanceRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })

  tags = var.config.tags
}

# Attach required policies to the IAM role
resource "aws_iam_role_policy_attachment" "ssm_managed_instance_core" {
  role       = aws_iam_role.ssm_instance_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_role_policy_attachment" "cloudwatch_agent" {
  role       = aws_iam_role.ssm_instance_role.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
}

# Create custom policy for KMS permissions
resource "aws_iam_policy" "kms_policy" {
  name        = "SSMInstanceKMSPolicy"
  description = "Allows EC2 instances to use KMS for SSM session encryption"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "kms:Decrypt",
          "kms:GenerateDataKey"
        ]
        Resource = [
          var.kms_key_arn
        ]
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "kms_policy_attachment" {
  role       = aws_iam_role.ssm_instance_role.name
  policy_arn = aws_iam_policy.kms_policy.arn
}

# Create IAM instance profile
resource "aws_iam_instance_profile" "ssm_instance_profile" {
  name = "ManagedInstanceProfile"
  role = aws_iam_role.ssm_instance_role.name
}