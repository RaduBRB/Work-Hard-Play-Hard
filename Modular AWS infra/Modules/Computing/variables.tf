variable "project" {
  description = "The project name"
  type        = string
}

variable "environment" {
  description = "The deployment environment (dev/staging/prod)"
  type        = string
}

variable "service_name" {
  description = "The name of the ECS service"
  type        = string
}

variable "private_subnets" {
  description = "List of private subnet IDs"
  type        = list(string)
}

variable "target_group_arn" {
  description = "ARN of the ALB target group"
  type        = string
}

variable "image" {
  description = "Container image URL"
  type        = string
}

variable "cpu" {
  description = "CPU units for the ECS task"
  type        = number
}

variable "memory" {
  description = "Memory (MiB) for the ECS task"
  type        = number
}

variable "desired_count" {
  description = "Number of ECS tasks to run"
  type        = number
}

variable "assign_public_ip" {
  description = "Whether to assign a public IP to the task"
  type        = bool
  default     = false
}

variable "log_retention" {
  description = "CloudWatch log retention in days"
  type        = number
  default     = 30
}

variable "security_groups" {
  description = "List of security group IDs for the ECS service"
  type        = list(string)
}