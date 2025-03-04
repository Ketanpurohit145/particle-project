aws_region         = "us-east-1"
vpc_name           = "my-vpc"
vpc_cidr           = "10.0.0.0/16"
public_subnets     = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnets    = ["10.0.3.0/24", "10.0.4.0/24"]
availability_zones = ["us-east-1a", "us-east-1b"]
bastion_key_name   = "linux-server-keypair"  # Existing key pair name
bastion_ami        = "ami-085ad6ae776d8f09c" # Replace with the Bastion AMI ID


#ECS module variables
ecs_cluster_name  = "my-ecs-cluster"
ecs_instance_type = "t2.micro"
#alb_name          = "my-app-alb"
#ecs_tg_name       = "my-ecs-tg"
container_image = "ketanpurohit145/simpletimeservice:0.0.6"

#ALB module variable 

alb_name    = "my-app-alb"
ecs_tg_name = "my-ecs-tg"