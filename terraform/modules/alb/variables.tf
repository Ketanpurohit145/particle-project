variable "alb_name" {
  description = "The name of the Application Load Balancer"
  type        = string
}

variable "ecs_tg_name" {
  description = "The name of the ECS Target Group"
  type        = string
}

variable "vpc_id" {
  description = "The ID of the VPC where the ALB will be created"
  type        = string
}

variable "public_subnets" {
  description = "List of public subnet IDs where ALB will be deployed"
  type        = list(string)
}


