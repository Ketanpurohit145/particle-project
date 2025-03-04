variable "aws_region" {
  description = "The AWS region to deploy resources in"
  type        = string
  default     = "us-east-1"
}

variable "vpc_name" {
  description = "The name of the VPC"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "public_subnets" {
  description = "List of cidr block for public subnet"
  type        = list(string)

}

variable "private_subnets" {
  description = "List of CIDR block for private subnet "
  type        = list(string)

}

variable "availability_zones" {
  description = "availbility zone"
  type        = list(string)

}

# variable "alb_security_group" {
#   description = "Security group ID of the ALB"
#   type        = string
# }

variable "container_image" {
  description = "Docker image for the ECS service"
  type        = string
}

variable "ecs_cluster_name" {
  description = "Name of the ECS cluster"
  type        = string
}

variable "ecs_instance_type" {
  description = "EC2 instance type for ECS instances"
  type        = string
}

variable "alb_name" {
  description = "The name of the Application Load Balancer"
  type        = string
}

variable "ecs_tg_name" {
  description = "The name of the ECS Target Group"
  type        = string
}

variable "bastion_key_name" {
  description = "Key pair to be used for the Bastion Host"
  type        = string
}

variable "bastion_ami" {
  description = "AMI ID for the Bastion Host"
  type        = string
}

# variable "bastion_security_group_id" {
#   description = "The ID of the bastion security group."
#   type        = string
# }