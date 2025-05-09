variable "config" {
  description = "Configuration object for CloudWatch resources"
  type        = any
}

variable "kms_key_arn" {
  description = "ARN of the KMS key used for SSM session encryption"
  type        = string
}