output "vpc_id" {
  description = "ID of the created VPC"
  value       = aws_vpc.main.id
}

output "public_subnets" {
  description = "IDs of the public subnets"
  value       = aws_subnet.public[*].id
}

output "private_subnets" {
  description = "IDs of the private subnets"
  value       = aws_subnet.private[*].id
}

output "ec2_sg_id" {
  description = "Security group ID for EC2 instances"
  value       = aws_security_group.ec2.id
}
