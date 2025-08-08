variable "project_name" {
  description = "Project name used as prefix"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID where the load balancer will be deployed"
  type        = string
}

variable "public_subnets" {
  description = "Public subnets for the load balancer"
  type        = list(string)
}

variable "target_group_arns" {
  description = "Target group ARNs to associate with the listener"
  type        = list(string)
  default     = []
}
