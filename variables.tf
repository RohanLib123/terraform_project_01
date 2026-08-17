variable "aws_provider_region" {
    type = string
    description = "Variable for Region using for AWS Povider"
  
}

variable "workspace_assume_roles" {
    type = map(string)
    default = {
        # arn of role that is going to use for dev environment
        dev = "arn:aws:iam::732343865328:role/terraform-dev-role-01"
        # arn of role that is going to use for production environment
        production = "arn:aws:iam::732343865328:role/terraform-prod-role-01"
    }
  
}


variable "vpc_cidr_block" {
  type = string
  description = "CIDR block for vpc"

  validation {
    condition     = can(cidrhost(var.vpc_cidr_block, 0))
    error_message = "vpc_cidr_block must be a valid CIDR block, e.g. 10.0.0.0/16."
  }
}

variable "instance_tenancy" {
  type = string
  description = "Instance tenancy "
}

variable "public_subnet_cidrs" {
  type = map(string)
  # e.g. { "ap-south-1a" = "10.0.1.0/24", "ap-south-1b" = "10.0.2.0/24" }
}

variable "private_subnet_cidrs" {
  type = map(string)
  # e.g. { "ap-south-1a" = "10.0.11.0/24", "ap-south-1b" = "10.0.12.0/24" }
}

variable "environment" {
    type = string
    description = "Name of environment"
  
}

variable "project_name" {
    type = string
    description = "Name of Project"
  
}

variable "owner_name" {
  type = string
  description = "Individual or Team Name"
}

variable "admin_ip_cidr" {
  type = string
  description = "CIDR allowed to SSH into EC2 instance (e.g. your office/VPN ip)"
}

variable "rds_port" {
  type = number
  description = "Port the RDS instance listen on e.g 1433"
}

variable "instance_ami" {
    type = string
    description = "ami id for instance to launch"
}

variable "ec2_instance_type" {
  type = string
  description = "Instance type according to requirement eg. t2.mirco, t3.micro"
}

variable "sg_ec2_id" {
  type = string
  description = "security group id exposed by ec2-sg module "
}

variable "public_subnet_01_id" {
  type = string
  description = "Subnet Id exposed by public-sub-01 module "
}

variable "s3_readonly_instance_profile_name" {
  type = string
  description = "Instance profile name exposed by s3-readonly-profile module"
}

variable "instance_tenancy" {
  type = string
  description = "Tenancy type for instance e.g. default, dedicated"
}

variable "ssh_key_name" {
  type = string
  description = "Name of SSH key"
}

variable "root_volume_size" {
  type = string
  description = "size of root volume e.g 8GB, 10GB"
}

variable "kms_key_id" {
  type = string
  description = "KMS Key id for encryption"
}

variable "s3_bucket_name" {
    type = string
    description = "The role of bucket name this role can read from"
}


#


variable "environment" {
    type = string
    description = "Name of environment"
  
}

variable "project_name" {
    type = string
    description = "Name of Project"
  
}

variable "owner_name" {
  type = string
  description = "Individual or Team Name"
}

variable "engine" {
  type = string
  description = "whiwhich engine or edition want e.g. custom-sqlserver-se "
}

variable "engine-version" {
  type = string
  description = "Verion of needed engine e.g. 15.00.4249.2.v1"
}

variable "storage_type" {
  type = string
  description = "Type of storage e.g. gp3"
}

variable "rds_instance_classes" {
  type = list(string)
  description = "Preferred instance classes for rds to lauch instance between e.g db.r5.xlarge, db.r5.2xlarge, db.r5.4xlarge"
}

variable "rds_kms_key_id" {
  type = string
  description = "KMS key id for rds instance"
}

variable "private_subnet_01_id" {
  type = string
  description = "subnet id exposed by private-sub-01 "
}

variable "private_subnet_02_id" {
  type = string
  description = "Subnet id exposed by private-sub-02"
}

variable "rds_identifier" {
  type = string
  description = "rds identifier e.g sql-instance-demo"
}

variable "rds_pass" {
  type = string
  description = "password for sql user"
  sensitive = true
  ephemeral = true
}

variable "rds_user_name" {
  type = string
  description = "username for sql user"
  sensitive = true
  ephemeral = true
}

variable "sg_rds_id" {
  type = string
  description = "rds security group id exposed by rds-sg "
}

variable "rds_instance_profile_name" {
  type = string
  description = "RDS instance profile name e.g. AWSRDSCustomSQLServerInstnaceProfile"
}

variable "storage_allocated" {
  type = number
  description = "value of allocated storafe e.g 500"
}

variable "bckp_retention_period" {
  type = number
  description = "Backup retention period e.g 7"
}

variable "backup_window" {
  type = string
  description = "backup window for db e.g 02:00-03:00"
}

variable "maintenance_window" {
  type = string
  description = "Maintenance window for db e.g. sun:20:00-sun:21:00"
}

variable "monitoring_interval_value" {
  type = number
  description = "moitoring interval value e.g 60"
}

variable "rds_monitoring_role_arn" {
  type = string
  description = "role arn for rds monitoring exposed by rds-monitoring module"
}


variable "backend_bucket_name" {
  type = string
  description = "backend s3 bucket name"
}

variable "backend_key" {
  type = string
  description = "path of terraform.tfstate in backend bucket"
}

variable "backend_bucket_region" {
  type = string
  description = "Region where backend bucker is"
}

