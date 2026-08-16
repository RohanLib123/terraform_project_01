output "instance_id" {
  value = aws_instance.instance-for-s3.id
}

output "instance_public_ip" {
  value = aws_instance.instance-for-s3.public_ip
}

