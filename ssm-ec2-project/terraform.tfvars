config = {
  aws_region                  = "us-east-1"
  instance_name               = "ssm-managed-instance"
  ec2_instance_ami            = "ami-0f88e80871fd81e91"
  ec2_instance_type           = "t2.micro"
  create_on_public_subnet     = true
  #ec2_instance_key_name       = "your-key-name" # Replace with your key name or remove if not needed
  enable_termination_protection = false
  root_volume_size            = "20"
  sg_name                     = "ssm-instance-sg"
  #allowed_ports               = [443, 80] # HTTPS and HTTP
  allowed_ips                 = {
    all = "0.0.0.0/0" # This allows traffic from anywhere - restrict as needed
  }
  tags                        = {
    Environment = "Development"
    ManagedBy   = "Terraform"
    Purpose     = "SSM-Managed-EC2"
  }
  vpc_id                      = "vpc-0b29462da246e0151" # Replace with your VPC ID
  private_subnet              = "subnet-private12345" # Replace with your private subnet ID
  public_subnet               = "subnet-08a96a34702e19938" # Replace with your public subnet ID
  iam_user_name               = "annie02" # Replace with your IAM user name
}