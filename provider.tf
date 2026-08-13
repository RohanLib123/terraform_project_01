terraform {
    # This required providers block is check mmaximum supprting verion 5.0
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~> 5.0"
    }
  }
}


provider "aws" {
  region = var.aws_provider_region
  assume_role {
    role_arn = var.workspace_assume_roles[terraform.workspace]
  }
}