output "instance_ids" {
  description = "IDs of the EC2 instances"
  value       = module.ec2.instance_ids
}

output "instance_public_ips" {
  description = "Public IP addresses of the EC2 instances (if applicable)"
  value       = module.ec2.instance_public_ips
}

output "instance_private_ips" {
  description = "Private IP addresses of the EC2 instances"
  value       = module.ec2.instance_private_ips
}

output "ssm_managed_instance_role_arn" {
  description = "ARN of the IAM role for SSM managed instances"
  value       = module.iam.role_arn
}

output "ssm_kms_key_arn" {
  description = "ARN of the KMS key used for SSM session encryption"
  value       = module.kms.kms_key_arn
}

output "ssm_log_group_name" {
  description = "Name of the CloudWatch log group for SSM session logs"
  value       = module.cloudwatch.log_group_name
}

output "security_group_id" {
  description = "ID of the security group attached to the EC2 instances"
  value       = module.security_group.security_group_id
}

output "ssm_connection_commands" {
  description = "Commands to connect to the instances via SSM Session Manager"
  value       = [for id in module.ec2.instance_ids : "aws ssm start-session --target ${id} --region ${var.config.aws_region}"]
}