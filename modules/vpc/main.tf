# Setting Locals
locals {
  common_tags = {
    Environment = var.environment
    Project     = var.project_name
    ManagedBy   = "Terraform"
    Owner       = var.owner_name
  }


  public_subnet_ids = {
    "public-subnet-01-${var.project_name}-${var.environment}" = aws_subnet.public-sub-01.id
    "public-subnet-02-${var.project_name}-${var.environment}" = aws_subnet.public-sub-02.id
  }


  private_subnet_ids = {
    "private-subnet-01-${var.project_name}-${var.environment}" = aws_subnet.private-sub-01.id
    "private-subnet-02-${var.project_name}-${var.environment}" = aws_subnet.private-sub-02.id
  }
}

# Creating VPC
resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr_block
  instance_tenancy     = var.instance_tenancy
  enable_dns_hostnames = true
  enable_dns_support   = true
  lifecycle {
    prevent_destroy = true
  }

  tags = merge(local.common_tags, {
    Name = "vpc-${var.project_name}-${var.environment}"

  })
}



# Creating Public Subnet 01
resource "aws_subnet" "public-sub-01" {
  for_each                = var.public_subnet_cidrs
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = each.value
  availability_zone       = each.key
  map_public_ip_on_launch = true


  tags = merge(local.common_tags, {
    Name = "public-subnet-01-${var.project_name}-${var.environment}"
    Tier = "public"
  })
}


# Creating Public Subnet 02
resource "aws_subnet" "public-sub-02" {
  for_each                = var.public_subnet_cidrs
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = each.value
  availability_zone       = each.key
  map_public_ip_on_launch = true

  tags = merge(local.common_tags, {
    Name = "public-subnet-02-${var.project_name}-${var.environment}"
    Tier = "public"
  })

}

# Creating Private Subnet 01
resource "aws_subnet" "private-sub-01" {
  for_each                = var.private_subnet_cidrs
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = each.value
  availability_zone       = each.key
  map_public_ip_on_launch = false

  tags = merge(local.common_tags, {
    Name = "private-subnet-01-${var.project_name}-${var.environment}"
    Tier = "private"
  })

}


# Creating Private Subnet 02
resource "aws_subnet" "private-sub-02" {
  for_each                = var.private_subnet_cidrs
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = each.value
  availability_zone       = each.key
  map_public_ip_on_launch = false

  tags = merge(local.common_tags, {
    Name = "private-subnet-02-${var.project_name}-${var.environment}"
    Tier = "private"
  })

}


# Creating Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  lifecycle {
    prevent_destroy = true
  }

  tags = merge(local.common_tags, {
    Name = "Internet-gateway-01-${var.project_name}-${var.environment}"
  })

}


# Creating Public Route table
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = merge(local.common_tags, {
    Name = "public-rtb-01-${var.project_name}-${var.environment}"
    Tier = "public"
  })

}


# Creating Public route table association
resource "aws_route_table_association" "public_sub_association" {
  for_each = local.public_subnet_ids

  subnet_id      = each.value
  route_table_id = aws_route_table.public_route_table.id

}


# Creating Private Route table
resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = var.vpc_cidr_block
    gateway_id = "local"
  }

  tags = merge(local.common_tags, {
    Name = "private-rtb-01-${var.project_name}-${var.environment}"
    Tier = "private"
  })
}

#Creating private route table association
resource "aws_route_table_association" "private_sub_association" {
  for_each = local.private_subnet_ids

  subnet_id      = each.value
  route_table_id = aws_route_table.private_route_table.id

}


#Creating Security group for EC2
resource "aws_security_group" "ec2-sg" {
  vpc_id      = aws_vpc.vpc.id
  description = "Security group to attach to EC2 instaces"
  lifecycle {
    create_before_destroy = true
  }

  tags = merge(local.common_tags, {
    Name = "sg-ec2-${var.project_name}-${var.environment}"
  })

  ingress {
    description = "Allow HTTP from Internet"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow HTTPS from Internet"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow SSH from Autherised only"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.admin_ip_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}


# Creating Security Group for RDS
resource "aws_security_group" "rds-sg" {
  vpc_id      = aws_vpc.vpc.id
  description = "Security Group for RDS Instance "
  lifecycle {
    create_before_destroy = true
  }

  tags = merge(local.common_tags, {
    Name = "sg-rds-${var.project_name}-${var.environment}"
  })

  ingress {
    description     = "Allow DB access from EC2 security group"
    from_port       = var.rds_port
    to_port         = var.rds_port
    protocol        = "tcp"
    security_groups = [aws_security_group.ec2-sg.id]
  }

  egress {
    description = "Allow outbound withing the VPC only"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.vpc_cidr_block]
  }

}


