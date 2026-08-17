terraform {
  backend "s3" {
    bucket = "ec2-s3-bucket"
    key    = "ec2-s3-bucket/capstone/terraform.tfstate"
    region = "ap-south-1"
  }
}