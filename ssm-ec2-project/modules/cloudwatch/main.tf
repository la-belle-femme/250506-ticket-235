# Create CloudWatch Log Group for SSM session logs
resource "aws_cloudwatch_log_group" "ssm_log_group" {
  name              = "/aws/ssm/sessions"
  retention_in_days = 30
  kms_key_id        = var.kms_key_arn

  tags = var.config.tags
}