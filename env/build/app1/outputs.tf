output "asg_name" {
  description = "Name of the Auto Scaling Group"
  value       = module.asg_module.autoscaling_group_name
}

output "asg_security_group_id" {
  description = "Security Group ID used by the ASG"
  value       = module.asg_module.security_group_id
}

output "asg_launch_template_id" {
  description = "Launch Template ID used by the ASG"
  value       = module.asg_module.launch_template_id
}
