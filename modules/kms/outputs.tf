output "kms_key_arn" {
  description = "ARN of the KMS key used for SSM session encryption"
  value       = aws_kms_key.ssm_kms_key.arn
}

output "kms_key_id" {
  description = "ID of the KMS key used for SSM session encryption"
  value       = aws_kms_key.ssm_kms_key.key_id
}

output "kms_alias_name" {
  description = "Alias name of the KMS key"
  value       = aws_kms_alias.ssm_kms_alias.name
}