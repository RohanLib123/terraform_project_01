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