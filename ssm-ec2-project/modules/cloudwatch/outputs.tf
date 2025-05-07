output "log_group_name" {
  description = "Name of the CloudWatch log group for SSM session logs"
  value       = aws_cloudwatch_log_group.ssm_log_group.name
}

output "log_group_arn" {
  description = "ARN of the CloudWatch log group for SSM session logs"
  value       = aws_cloudwatch_log_group.ssm_log_group.arn
}