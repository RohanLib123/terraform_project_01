#exposing VPC Id
output "vpc_id" {
  value = aws_vpc.vpc.id
}

#expsing vpc cidr block
output "vpc_cidr_block" {
  value = aws_vpc.vpc.cidr_block
}

#exposing VPC arn
output "vpc_arn" {
  value = aws_vpc.vpc.arn
}

output "public_subnet_01_id" {
  value = aws_subnet.public["ap-south-1a"].id
}

output "public_subnet_02_id" {
  value = aws_subnet.public["ap-south-1b"].id
}

output "private_subnet_01_id" {
  value = aws_subnet.private["ap-south-1a"].id
}

output "private_subnet_02_id" {
  value = aws_subnet.private["ap-south-1b"].id
}

#Exposing Internet Gateway id
output "igw_id" {
  value = aws_internet_gateway.igw.id
}

#Exposing Public Route Table id
output "pub_rtb_id" {
  value = aws_route_table.public_route_table.id
}

#Exposing Private Route Table id
output "pvt_rtb_id" {
  value = aws_route_table.private_route_table.id
}

#Exposing id of Security group which is for EC2 
output "sg_ec2_id" {
  value = aws_security_group.ec2-sg.id
}

#Exposing id of Security Group which is for RDS
output "sg_rds_id" {
  value = aws_security_group.rds-sg.id
}

