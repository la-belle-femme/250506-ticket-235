output "role_arn" {
  description = "ARN of the IAM role for SSM managed instances"
  value       = aws_iam_role.ssm_instance_role.arn
}

output "role_name" {
  description = "Name of the IAM role for SSM managed instances"
  value       = aws_iam_role.ssm_instance_role.name
}

output "instance_profile_name" {
  description = "Name of the IAM instance profile"
  value       = aws_iam_instance_profile.ssm_instance_profile.name
}

output "instance_profile_arn" {
  description = "ARN of the IAM instance profile"
  value       = aws_iam_instance_profile.ssm_instance_profile.arn
}