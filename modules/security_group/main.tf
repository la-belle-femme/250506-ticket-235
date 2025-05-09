# Create security group for EC2 instances
resource "aws_security_group" "instance_sg" {
  name        = var.config.sg_name
  description = "Security group for EC2 instances managed by SSM"
  vpc_id      = var.config.vpc_id

  dynamic "ingress" {
    for_each = var.config.allowed_ports
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = [var.config.allowed_ips["all"]]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    var.config.tags,
    {
      Name = var.config.sg_name
    }
  )
}