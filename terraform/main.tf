module "vpc" {
  source                 = "./modules/vpc"
  vpc_name               = var.vpc_name
  cidr_block             = var.vpc_cidr
  public_subnets         = var.public_subnets
  private_subnets        = var.private_subnets
  availability_zones     = var.availability_zones
  enable_nat_gateways    = true
  bastion_key_name       = var.bastion_key_name
  bastion_ami            = var.bastion_ami
  bastion_subnet         = module.vpc.public_subnets[0] # Get the first public subnet
  #bastion_security_group = module.vpc.bastion_security_group_id
  bastion_security_group_id = module.vpc.bastion_security_group_id
}

# ALB Module
module "alb" {
  source         = "./modules/alb"
  vpc_id         = module.vpc.vpc_id
  public_subnets = module.vpc.public_subnet_ids
  alb_name       = var.alb_name
  ecs_tg_name    = var.ecs_tg_name
}

# ECS Module (Running on EC2 in Private Subnets, No Auto Scaling)
module "ecs" {
  source               = "./modules/ecs"
  cluster_name         = var.ecs_cluster_name
  vpc_id               = module.vpc.vpc_id
  private_subnets      = module.vpc.private_subnet_ids
  instance_type        = var.ecs_instance_type
  alb_target_group_arn = module.alb.target_group_arn
  alb_security_group   = module.alb.alb_security_group_id
  container_image      = var.container_image
  bastion_security_group_id = module.vpc.bastion_security_group_id
  bastion_key_name       = var.bastion_key_name
}



