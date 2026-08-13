# Setting Locals
locals {
  common_tags = {
    Environment = var.environment
    Project = var.project_name
    ManagedBy = "Terraform"
    Owner = var.owner_name
  }
}

# Creating VPC
resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr_block
  instance_tenancy = var.instance_tenancy
  enable_dns_hostnames = true
  enable_dns_support = true
  lifecycle {
    prevent_destroy = true
  }

  tags = merge(local.common_tags, {
    Name = "vpc-${var.project_name}-${var.environment}"
    
  })
}

