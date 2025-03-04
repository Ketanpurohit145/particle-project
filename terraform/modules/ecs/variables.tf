variable "cluster_name" { 
    type = string 
}

variable "vpc_id" { 
    type = string 
}

variable "private_subnets" { 
    type = list(string) 
}

variable "instance_type" { 
    type = string 
}

variable "alb_target_group_arn" { 
    type = string 
}

variable "alb_security_group" { 
    type = string 
}

variable "container_image" { 
    type = string 
}    

variable "bastion_security_group_id" {
  description = "The ID of the bastion security group."
  type        = string
}

variable "bastion_key_name" {
  description = "The name of the SSH key pair to use for EC2 instances"
  type        = string
}