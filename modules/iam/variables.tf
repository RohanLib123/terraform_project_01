variable "environment" {
  type        = string
  description = "Name of environment"

}

variable "project_name" {
  type        = string
  description = "Name of Project"

}

variable "owner_name" {
  type        = string
  description = "Individual or Team Name"
}

variable "s3_bucket_name" {
  type        = string
  description = "The role of bucket name this role can read from"
}

