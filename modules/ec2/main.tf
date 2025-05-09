resource "aws_instance" "ec2_instance" {
  count                    = var.instance_count
  ami                      = var.config.ec2_instance_ami
  instance_type            = var.config.ec2_instance_type
  #key_name                 = var.config.ec2_instance_key_name
  vpc_security_group_ids   = [var.security_group_id]
  subnet_id                = var.config.create_on_public_subnet ? var.config.public_subnet : var.config.private_subnet
  iam_instance_profile     = var.instance_profile_name
  disable_api_termination  = var.config.enable_termination_protection

  root_block_device {
    volume_size = var.config.root_volume_size
    encrypted   = true
  }

  user_data = <<-EOF
              #!/bin/bash
              # Ensure SSM agent is installed and running
              if [ -f /etc/amazon-linux-release ]; then
                # Amazon Linux 2
                yum update -y
                yum install -y amazon-ssm-agent
                systemctl enable amazon-ssm-agent
                systemctl start amazon-ssm-agent
              elif [ -f /etc/debian_version ]; then
                # Debian/Ubuntu
                apt-get update
                apt-get install -y amazon-ssm-agent
                systemctl enable amazon-ssm-agent
                systemctl start amazon-ssm-agent
              fi
              EOF

  tags = merge(
    var.config.tags,
    {
      Name = "${var.config.instance_name}-${count.index + 1}"
    }
  )

  lifecycle {
    ignore_changes = [ami]
  }
}