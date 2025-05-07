output "security_group_id" {
  description = "ID of the security group"
  value       = aws_security_group.instance_sg.id
}

output "security_group_name" {
  description = "Name of the security group"
  value       = aws_security_group.instance_sg.name
}