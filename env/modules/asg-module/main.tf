resource "aws_security_group" "asg_sg" {
  name        = var.security_group_name
  description = "Allow SSH and HTTP(s) traffic"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.allowed_ssh_cidr_blocks
    description = "Allow SSH"
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow HTTP"
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow HTTPS"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all outbound traffic"
  }

  tags = {
    Name = var.security_group_name
  }
}

resource "aws_launch_template" "asg_launch_template" {
  name_prefix   = "asg-launch-template-"
  image_id      = var.ami_id
  instance_type = var.instance_type

  key_name = var.key_name

  security_group_names = [aws_security_group.asg_sg.name]

  user_data = base64encode(var.user_data)

  tag_specifications {
    resource_type = "instance"

    tags = merge(
      {
        Name = "ASG-Launch-Template"
      },
      var.instance_tags
    )
  }
}

resource "aws_autoscaling_group" "asg" {
  launch_template {
    id      = aws_launch_template.asg_launch_template.id
    version = "$Latest"
  }

  vpc_zone_identifier = var.subnet_ids

  min_size         = var.min_size
  max_size         = var.max_size
  desired_capacity = var.desired_capacity

  health_check_type         = var.health_check_type
  health_check_grace_period = var.health_check_grace_period

  tag {
    key                 = "Name"
    value               = var.asg_tag_name
    propagate_at_launch = true
  }

  lifecycle {
    create_before_destroy = true
  }
}
