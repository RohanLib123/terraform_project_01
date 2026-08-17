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

variable "instance_ami" {
  type        = string
  description = "ami id for instance to launch"
}

variable "ec2_instance_type" {
  type        = string
  description = "Instance type according to requirement eg. t2.mirco, t3.micro"
}

variable "sg_ec2_id" {
  type        = string
  description = "security group id exposed by ec2-sg module "
}

variable "public_subnet_01_id" {
  type        = string
  description = "Subnet Id exposed by public-sub-01 module "
}

variable "s3_readonly_instance_profile_name" {
  type        = string
  description = "Instance profile name exposed by s3-readonly-profile module"
}

variable "s3_readonly_role_arn" {
  type        = string
  description = "Role arn exposed by s3_readonly_role module"
}

variable "instance_tenancy" {
  type        = string
  description = "Tenancy type for instance e.g. default, dedicated"
}

variable "ssh_key_name" {
  type        = string
  description = "Name of SSH key"
}

variable "root_volume_size" {
  type        = string
  description = "size of root volume e.g 8GB, 10GB"
}

variable "kms_key_id" {
  type        = string
  description = "KMS Key id for encryption"
}

