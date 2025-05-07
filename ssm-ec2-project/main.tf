provider "aws" {
  region = var.config.aws_region
}

# Import modules
module "kms" {
  source = "./modules/kms"
  
  config = var.config
}

module "iam" {
  source = "./modules/iam"
  
  config = var.config
  kms_key_arn = module.kms.kms_key_arn
}

module "security_group" {
  source = "./modules/security_group"
  
  config = var.config
}

module "cloudwatch" {
  source = "./modules/cloudwatch"
  
  config = var.config
  kms_key_arn = module.kms.kms_key_arn
}

module "ssm" {
  source = "./modules/ssm"
  
  config = var.config
  kms_key_arn = module.kms.kms_key_arn
  log_group_name = module.cloudwatch.log_group_name
  ec2_instance_ids = module.ec2.instance_ids
}

module "ec2" {
  source = "./modules/ec2"
  
  config = var.config
  instance_count = 3
  instance_profile_name = module.iam.instance_profile_name
  security_group_id = module.security_group.security_group_id
}