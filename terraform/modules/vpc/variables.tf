variable "vpc_name" {
  description = "The name of the VPC"
  type        = string
}

variable "cidr_block" {
  description = "The CIDR block for the VPC"
  type        = string
}

variable "public_subnets" {
  description = "List of CIDR blocks for public subnets"
  type        = list(string)
}

variable "private_subnets" {
  description = "List of CIDR blocks for private subnets"
  type        = list(string)
}

variable "availability_zones" {
  description = "List of availability zones"
  type        = list(string)
}

variable "enable_nat_gateways" {
  description = "Whether to enable NAT gateways"
  type        = bool
  default     = true
}

variable "existing_key_pair" {
  description = "Name of the existing key pair for SSH access"
  type        = string
  default     = "linux-server-keypair"
}


variable "bastion_instance_type" {
  description = "Instance type for the Bastion Host"
  default     = "t2.micro"  # Can be adjusted as per your requirements
}


variable "bastion_key_name" {
  description = "Name of the existing AWS key pair"
  type        = string
  default     = "linux-server-keypair"  # Your existing key pair name
}

variable "bastion_ami" {
  description = "AMI ID for the Bastion Host"
  type        = string
}

variable "bastion_subnet" {
  description = "The subnet in which to launch the Bastion Host"
  type        = string
}

variable "bastion_security_group_id" {
  description = "The security group to apply to the Bastion Host"
  type        = string
}
