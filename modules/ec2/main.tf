# Setting Locals
locals {
  common_tags = {
    Environment = var.environment
    Project = var.project_name
    ManagedBy = "Terraform"
    Owner = var.owner_name
  }
}


#creating an ec2 instance
resource "aws_instance" "instance-for-s3" {
    ami = var.instance_ami
    instance_type = var.ec2_instance_type
    subnet_id = var.public_subnet_01_id
    vpc_security_group_ids = [ var.sg_ec2_id]
    iam_instance_profile = var.s3_readonly_instance_profile_name
    tenancy = var.instance_tenancy
    disable_api_stop = true 
    disable_api_termination = true
    key_name = var.ssh_key_name
    monitoring = true
    ebs_optimized = true
    associate_public_ip_address = true
    
    lifecycle {
      ignore_changes = [ ami ]
    }
      
    root_block_device {
      volume_type = "gp3"
      volume_size = var.root_volume_size
      encrypted = true
      kms_key_id = var.kms_key_id
      delete_on_termination = true

      tags = merge(local.common_tags, {
        Name = "root-vol-${var.project_name}-${var.environment}"
      })
    }

    metadata_options {
      http_endpoint = "enabled"
      http_tokens = "required"
      http_put_response_hop_limit = 1
    }


    tags = merge(local.common_tags, {
        Name = "checking-instance-${var.project_name}-${var.environment}"
    })
  
}