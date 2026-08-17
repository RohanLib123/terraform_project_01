variable "vpc_cidr_block" {
  type        = string
  description = "CIDR block for vpc"

  validation {
    condition     = can(cidrhost(var.vpc_cidr_block, 0))
    error_message = "vpc_cidr_block must be a valid CIDR block, e.g. 10.0.0.0/16."
  }
}

variable "instance_tenancy" {
  type        = string
  description = "Instance tenancy "
}

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

variable "public_subnet_cidrs" {
  type = map(string)
  # e.g. { "ap-south-1a" = "10.0.1.0/24", "ap-south-1b" = "10.0.2.0/24" }
}



variable "private_subnet_cidrs" {
  type = map(string)
  # e.g. { "ap-south-1a" = "10.0.11.0/24", "ap-south-1b" = "10.0.12.0/24" }
}

variable "admin_ip_cidr" {
  type        = string
  description = "CIDR allowed to SSH into EC2 instance (e.g. your office/VPN ip)"
}

variable "rds_port" {
  type        = number
  description = "Port the RDS instance listen on e.g 1433"
}



