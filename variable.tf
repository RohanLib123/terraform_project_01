variable "aws_provider_region" {
    type = string
    description = "Variable for Region using for AWS Povider"
  
}

variable "workspace_assume_roles" {
    default = {
        # arn of role that is going to use for dev environment
        dev = "arn:aws:iam::732343865328:role/terraform-dev-role-01"
        # arn of role that is going to use for production environment
        production = "arn:aws:iam::732343865328:role/terraform-prod-role-01"
    }
  
}