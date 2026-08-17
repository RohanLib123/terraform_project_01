output "ec2_instance_public_ip" {
  value = module.instance-for-s3.instance_public_ip
}

output "vpc_id" {
  value = module.vpc.vpc_id
}

output "rds_endpoint" {
  value = module.aws_db_instance.rds_server_endpoint
}

output "public_subnet_id_01" {
  value = module.vpc.public_subnet_01_id
}

output "public_subnet_id_02" {
  value = module.vpc.public_subnet_02_id
}

output "private_subnet_id_01" {
  value = module.vpc.private_subnet_01_id
}

output "private_subnet_id_02" {
  value = module.vpc.private_subnet_02_id
}

output "ec2_instance_id" {
  value = module.instance-for-s3.instance_id
}

output "rds_identifier" {
  value = module.aws_db_instance.rds_identifier
}