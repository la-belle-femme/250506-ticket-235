variable "config" {
  type = object({
    aws_region                  = string
    instance_name               = string
    ec2_instance_ami            = string
    ec2_instance_type           = string
    create_on_public_subnet     = bool
    ec2_instance_key_name       = string
    enable_termination_protection = bool
    root_volume_size            = string
    sg_name                     = string
    allowed_ports               = list(number)
    allowed_ips                 = map(string)
    tags                        = map(any)
    vpc_id                      = string
    private_subnet              = string
    public_subnet               = string
    iam_user_name               = string
  })
  description = "Configuration map for EC2 instance and associated resources"
}