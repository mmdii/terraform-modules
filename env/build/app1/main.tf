# main.tf

terraform {
  required_version = ">= 1.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region = var.region
}

module "asg_module" {
  source = "../../modules/asg-module"

  region                  = var.region
  vpc_id                  = var.vpc_id
  subnet_ids              = var.subnet_ids
  ami_id                  = var.ami_id
  instance_type           = var.instance_type
  key_name                = var.key_name
  allowed_ssh_cidr_blocks = var.allowed_ssh_cidr_blocks
  user_data               = var.user_data
  asg_tag_name            = var.asg_tag_name
  instance_tags = {
    Environment = "Production"
    Project     = "MyApp"
  }
}
