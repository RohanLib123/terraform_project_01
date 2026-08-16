# Setting Locals
locals {
  common_tags = {
    Environment = var.environment
    Project = var.project_name
    ManagedBy = "Terraform"
    Owner = var.owner_name
  }
}


# Define who can assume this role ( trust policy )
#In this project Role is going to use
data "aws_iam_policy_document" "assume_role_source" {
    statement {
      actions = ["sts:AssumeRole"]
      effect = "Allow"

      principals {
        type = "Service"
        identifiers = ["ec2.amazonaws.com"]
      }
    }
}


#Creating the IAM role and linking the assume role policy to it
resource "aws_iam_role" "s3_readonly_role" {
    name = "s3-readonly-access-role-${var.project_name}-${var.environment}"
    assume_role_policy = data.aws_iam_policy_document.assume_role_source.json
    description = "Role assume by ec2 instance for read-only access to ${var.s3_bucket_name}"

    tags = merge(local.common_tags)
  
}


# Defining the s3 read-obly permissons policy
data "aws_iam_policy_document" "s3_readonly_permissions" {
    #permisson to list the bucket contents
    statement {
      sid = "ListBucketContents"
      effect = "Allow"
      actions = ["s3:ListBucket", "s3:GetBucketLocation"]
      resources = ["arn:aws:s3:::${var.s3_bucket_name}"]  
    }


    #permission to download objects form bucket
    statement {
      sid = "ReadObjects"
      effect = "Allow"
      actions = ["s3:GetObject", "s3:GetObjectVersion"]
      resources = ["arn:aws:s3:::${var.s3_bucket_name}/*"]
    }
}


#provisioning the permission policy
resource "aws_iam_policy" "s3_readonly_policy" {
    name = "s3ReadOnlyAccessPolicy-${var.project_name}-${var.environment}"
    description = "Provides readonly access to specific s3 bucket"
    policy = data.aws_iam_policy_document.s3_readonly_permissions.json

    tags = merge(local.common_tags)
}


# Attaching the policy to the IAM role
resource "aws_iam_role_policy_attachment" "attach_s3_readonly" {
    role = aws_iam_role.s3_readonly_role.name
    policy_arn = aws_iam_policy.s3_readonly_policy.arn
}


#Creating instance profile to wrappig the role
resource "aws_iam_instance_profile" "s3_readonly_profile" {
    name = "s3-readonly-instance-profile-${var.project_name}-${var.environment}"
    role = aws_iam_role.s3_readonly_role.name
}

