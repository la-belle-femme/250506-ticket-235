variable "config" {
  description = "Configuration object for SSM resources"
  type        = any
}

variable "kms_key_arn" {
  description = "ARN of the KMS key used for SSM session encryption"
  type        = string
}

variable "log_group_name" {
  description = "Name of the CloudWatch log group for SSM session logs"
  type        = string
}

variable "ec2_instance_ids" {
  description = "List of EC2 instance IDs to associate with SSM"
  type        = list(string)
}