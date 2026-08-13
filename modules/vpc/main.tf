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



# Creating Public Subnet 01
resource "aws_subnet" "public-sub-01" { 
    for_each = var.public_subnet_cidrs
    vpc_id = aws_vpc.vpc.id
    cidr_block = each.value
    availability_zone = each.key
    map_public_ip_on_launch = true


  tags = merge(local.common_tags, {
    Name = "public-subnet-01-${var.project_name}-${var.environment}"
    Tier = "public"
  })
}


# Creating Public Subnet 02
resource "aws_subnet" "public-sub-02" {
    for_each = var.public_subnet_cidrs
    vpc_id = aws_vpc.vpc.id
    cidr_block = each.value
    availability_zone = each.key
    map_public_ip_on_launch = true  

    tags = merge(local.common_tags, {
        Name = "public-subnet-02-${var.project_name}-${var.environment}"
        Tier = "public"
    })
  
}

# Creating Private Subnet 01
resource "aws_subnet" "private-sub-01" {
    for_each = var.private_subnet_cidrs
    vpc_id = aws_vpc.vpc.id
    cidr_block = each.value
    availability_zone = each.key
    map_public_ip_on_launch = false

    tags = merge(local.common_tags, {
        Name = "private-subnet-01-${var.project_name}-${var.environment}"
        Tier = "private"
    })
  
}


# Creating Private Subnet 02
resource "aws_subnet" "private-sub-02" {
    for_each = var.private_subnet_cidrs
    vpc_id = aws_vpc.vpc.id
    cidr_block = each.value
    availability_zone = each.key
    map_public_ip_on_launch = false

    tags = merge(local.common_tags, {
        Name = "private-subnet-02-${var.project_name}-${var.environment}"
        Tier = "private"
    })
  
}