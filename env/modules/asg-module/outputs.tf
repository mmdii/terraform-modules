# modules/asg-module/outputs.tf

output "autoscaling_group_name" {
  description = "The name of the Auto Scaling Group"
  value       = aws_autoscaling_group.asg.name
}

output "security_group_id" {
  description = "The ID of the Security Group"
  value       = aws_security_group.asg_sg.id
}

output "launch_template_id" {
  description = "The ID of the Launch Template"
  value       = aws_launch_template.asg_launch_template.id
}
