output "s3_readonly_role_arn" {
    value = aws_iam_role.s3_readonly_role.arn
}

output "s3_readonly_instance_profile_name" {
    value = aws_iam_instance_profile.s3_readonly_profile.name
}