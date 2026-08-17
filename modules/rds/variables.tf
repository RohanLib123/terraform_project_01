
variable "environment" {
  type        = string
  description = "Name of environment"

}

variable "project_name" {
  type        = string
  description = "Name of Project"

}

variable "owner_name" {
  type        = string
  description = "Individual or Team Name"
}

variable "engine" {
  type        = string
  description = "whiwhich engine or edition want e.g. custom-sqlserver-se "
}

variable "engine-version" {
  type        = string
  description = "Verion of needed engine e.g. 15.00.4249.2.v1"
}

variable "storage_type" {
  type        = string
  description = "Type of storage e.g. gp3"
}

variable "rds_instance_classes" {
  type        = list(string)
  description = "Preferred instance classes for rds to lauch instance between e.g db.r5.xlarge, db.r5.2xlarge, db.r5.4xlarge"
}

variable "rds_kms_key_id" {
  type        = string
  description = "KMS key id for rds instance"
}

variable "private_subnet_01_id" {
  type        = string
  description = "subnet id exposed by private-sub-01 "
}

variable "private_subnet_02_id" {
  type        = string
  description = "Subnet id exposed by private-sub-02"
}

variable "rds_identifier" {
  type        = string
  description = "rds identifier e.g sql-instance-demo"
}

variable "rds_pass" {
  type        = string
  description = "password for sql user"
  sensitive   = true
}

variable "rds_user_name" {
  type        = string
  description = "username for sql user"
  sensitive   = true
}

variable "sg_rds_id" {
  type        = string
  description = "rds security group id exposed by rds-sg "
}

variable "rds_instance_profile_name" {
  type        = string
  description = "RDS instance profile name e.g. AWSRDSCustomSQLServerInstnaceProfile"
}

variable "storage_allocated" {
  type        = number
  description = "value of allocated storafe e.g 500"
}

variable "bckp_retention_period" {
  type        = number
  description = "Backup retention period"
}

variable "backup_window" {
  type        = string
  description = "backup window for db e.g 02:00-03:00"
}

variable "maintenance_window" {
  type        = string
  description = "Maintenance window for db e.g. sun:20:00-sun:21:00"
}
