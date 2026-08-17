# Setting Locals
locals {
  common_tags = {
    Environment = var.environment
    Project = var.project_name
    ManagedBy = "Terraform"
    Owner = var.owner_name
  }

}

#Lookup the available instance classes for custom engine
data "aws_rds_orderable_db_instance" "custom-sqlserver" {
    engine = var.engine
    engine_version = var.engine-version
    storage_type = var.storage_type
    preferred_instance_classes = var.rds_instance_classes
}

#RDS instance requires KMS key ARN, Lookup for KMS KEY ARN
data "aws_kms_key" "by_id" {
  key_id = var.rds_kms_key_id #kms key 
}

#Creating RDS db instance 
resource "aws_db_instance" "rds_db_instnace_01" {
  allocated_storage = var.storage_allocated
  auto_minor_version_upgrade = false # Custom for sql server does not support minor version upgrades
  custom_iam_instance_profile =  var.rds_instance_profile_name # Instance profile is require for custom SQL server
  backup_retention_period = var.bckp_retention_period
  db_subnet_group_name = aws_db_subnet_group.db_subnet_group.name
  engine = data.aws_rds_orderable_db_instance.custom-sqlserver.engine
  engine_version = data.aws_rds_orderable_db_instance.custom-sqlserver.engine_version
  identifier = var.rds_identifier
  instance_class = data.aws_rds_orderable_db_instance.custom-sqlserver.instance_class
  kms_key_id = data.aws_kms_key.by_id.arn
  multi_az = false # Custom for sql server does not support multi az
  password = var.rds_pass
  storage_encrypted = true
  username = var.rds_user_name
  vpc_security_group_ids = [var.sg_rds_id]
  publicly_accessible = false
  deletion_protection = true
  skip_final_snapshot = false 
  storage_type = data.aws_rds_orderable_db_instance.custom-sqlserver.storage_type
  copy_tags_to_snapshot = true 
  backup_window = var.backup_window
  monitoring_interval = var.monitoring_interval_value
  monitoring_role_arn = var.rds_monitoring_role_arn
  performance_insights_enabled = true
  performance_insights_kms_key_id = data.aws_kms_key.by_id.arn

  

  lifecycle {
    prevent_destroy = true
    ignore_changes = [ password ]
  }



  timeouts {
    create = "3h"
    delete = "3h"
    update = "3h"
  }


  tags = merge(local.common_tags, {
    Name = "sql-db-instance=${var.project_name}-${var.environment}"
  })
}

#Creating Subnet group for database
resource "aws_db_subnet_group" "db_subnet_group" {
  name = "${var.rds_identifier}-subnet-group"
  subnet_ids = [var.private_subnet_01_id, var.private_subnet_02_id]
  
  tags = merge(local.common_tags)
}