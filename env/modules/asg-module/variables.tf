# modules/asg-module/variables.tf

variable "region" {
  description = "The AWS region to deploy resources."
  type        = string
  default     = "us-east-1"
}

variable "vpc_id" {
  description = "The ID of the VPC where resources will be deployed."
  type        = string
}

variable "subnet_ids" {
  description = "A list of subnet IDs for the Auto Scaling Group."
  type        = list(string)
}

variable "ami_id" {
  description = "The AMI ID for the EC2 instances."
  type        = string
}

variable "instance_type" {
  description = "The EC2 instance type."
  type        = string
  default     = "t2.micro"
}

variable "key_name" {
  description = "The name of the SSH key pair."
  type        = string
}

variable "security_group_name" {
  description = "The name of the Security Group."
  type        = string
  default     = "asg-security-group"
}

variable "allowed_ssh_cidr_blocks" {
  description = "List of CIDR blocks allowed to SSH."
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "user_data" {
  description = "The user data script to initialize EC2 instances."
  type        = string
  default     = <<-EOF
                #!/bin/bash
                echo "Hello, World!" > /var/www/html/index.html
                yum install -y httpd
                systemctl start httpd
                systemctl enable httpd
                EOF
}

variable "min_size" {
  description = "Minimum number of instances in the ASG."
  type        = number
  default     = 1
}

variable "max_size" {
  description = "Maximum number of instances in the ASG."
  type        = number
  default     = 1
}

variable "desired_capacity" {
  description = "Desired number of instances in the ASG."
  type        = number
  default     = 1
}

variable "health_check_type" {
  description = "The service to use for the health checks."
  type        = string
  default     = "EC2"
}

variable "health_check_grace_period" {
  description = "The amount of time, in seconds, that Auto Scaling waits before checking the health of an instance."
  type        = number
  default     = 300
}

variable "asg_tag_name" {
  description = "The Name tag value for instances in the ASG."
  type        = string
  default     = "ASG-Instance"
}

variable "instance_tags" {
  description = "Additional tags to apply to instances."
  type        = map(string)
  default     = {}
}
