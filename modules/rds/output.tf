output "rds_server_endpoint" {
  value = aws_db_instance.rds_db_instnace_01.endpoint
}

output "rds_identifier" {
  value = aws_db_instance.rds_db_instnace_01.identifier
}