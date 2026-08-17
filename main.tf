module "vpc" {
  source               = "./modules/vpc"
  vpc_cidr_block       = var.vpc_cidr_block
  instance_tenancy     = var.instance_tenancy
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  admin_ip_cidr        = [var.admin_ip_cidr]
  rds_port             = var.rds_port
  project_name         = var.project_name
  environment          = var.environment
  owner_name           = var.owner_name
}


module "instance-for-s3" {
  source                            = "./modules/ec2"
  instance_ami                      = var.instance_ami
  ec2_instance_type                 = var.ec2_instance_type
  public_subnet_01_id               = module.vpc.public_subnet_01_id
  sg_ec2_id                         = module.vpc.sg_ec2_id
  s3_readonly_instance_profile_name = module.iam.s3_readonly_instance_profile_name
  instance_tenancy                  = var.instance_tenancy
  ssh_key_name                      = var.ssh_key_name
  root_volume_size                  = var.root_volume_size
  kms_key_id                        = var.kms_key_id
  project_name                      = var.project_name
  environment                       = var.environment
  owner_name                        = var.owner_name
  s3_readonly_role_arn              = module.s3_readonly_role.s3_readonly_role_arn
}


module "s3_readonly_role" {
  source         = "./modules/iam"
  project_name   = var.project_name
  environment    = var.environment
  owner_name     = var.owner_name
  s3_bucket_name = var.s3_bucket_name
}


module "aws_db_instance" {
  source                    = "./modules/rds"
  project_name              = var.project_name
  environment               = var.environment
  owner_name                = var.owner_name
  engine                    = var.engine
  engine-version            = var.engine-version
  storage_type              = var.storage_type
  rds_instance_classes      = var.rds_instance_classes
  rds_kms_key_id            = var.rds_kms_key_id
  private_subnet_01_id      = module.vpc.private_subnet_01_id
  private_subnet_02_id      = module.vpc.private_subnet_o2_id
  rds_identifier            = var.rds_identifier
  rds_pass                  = var.rds_pass
  rds_user_name             = var.rds_user_name
  sg_rds_id                 = module.vpc.sg_rds_id
  rds_instance_profile_name = var.rds_instance_profile_name
  storage_allocated         = var.storage_allocated
  bckp_retention_period     = var.bckp_retention_period
  backup_window             = var.backup_window
  maintenance_window        = var.maintenance_window
  monitoring_interval_value = var.monitoring_interval_value
  rds_monitoring_role_arn   = module.rds_monitoring.rds_monitoring_role_arn
}


