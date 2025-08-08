variable "project_name" {
  description = "Project name used as prefix"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID where resources will be deployed"
  type        = string
}

variable "subnets" {
  description = "Subnets for the Auto Scaling Group"
  type        = list(string)
}

variable "security_group_ids" {
  description = "Security groups associated with the instances"
  type        = list(string)
}

variable "target_group_arns" {
  description = "Target group ARNs for the Auto Scaling Group"
  type        = list(string)
  default     = []
}
