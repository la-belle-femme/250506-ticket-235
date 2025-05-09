variable "config" {
  description = "Configuration object for EC2 instances"
  type        = any
}

variable "instance_count" {
  description = "Number of EC2 instances to create"
  type        = number
  default     = 3
}

variable "instance_profile_name" {
  description = "Name of the IAM instance profile to attach to the EC2 instances"
  type        = string
}

variable "security_group_id" {
  description = "ID of the security group to attach to the EC2 instances"
  type        = string
}