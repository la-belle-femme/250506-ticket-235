output "instance_ids" {
  description = "IDs of the EC2 instances"
  value       = aws_instance.ec2_instance[*].id
}

output "instance_public_ips" {
  description = "Public IP addresses of the EC2 instances"
  value       = aws_instance.ec2_instance[*].public_ip
}

output "instance_private_ips" {
  description = "Private IP addresses of the EC2 instances"
  value       = aws_instance.ec2_instance[*].private_ip
}