#exposing VPC Id
output "vpc_id" {
    value = aws_vpc.vpc.id
}

#expsing vpc cider block
output "vpc_cidr_block" {
    value = aws_vpc.vpc.cidr_block
}

#exposing VPC arn
output "vpc_arn" {
    value = aws_vpc.vpc.arn
}