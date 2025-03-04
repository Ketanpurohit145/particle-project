# Create ECS Cluster
resource "aws_ecs_cluster" "this" {
  name = var.cluster_name
}

# Create IAM Role for ECS Instances
resource "aws_iam_role" "ecs_instance_role" {
  name = "${var.cluster_name}-ecs-instance-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = [
            "ecs-tasks.amazonaws.com",
            "ec2.amazonaws.com"
          ]

      }
      Action = "sts:AssumeRole"
    }]
  })
}

# Attach ECS policies to allow instances to join ECS cluster
resource "aws_iam_role_policy_attachment" "ecs_instance_policy" {
  role       = aws_iam_role.ecs_instance_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
}

# Create ECS Instance Profile
resource "aws_iam_instance_profile" "ecs_instance_profile" {
  name = "${var.cluster_name}-instance-profile"
  role = aws_iam_role.ecs_instance_role.name
}

# Security Group for ECS Instances
resource "aws_security_group" "ecs_sg" {
  name_prefix = "${var.cluster_name}-sg"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 5000
    to_port     = 5000
    protocol    = "tcp"
    security_groups = [var.alb_security_group]
  }

  # New ingress rule to allow SSH from Bastion Host
  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [var.bastion_security_group_id]
  }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Launch Two ECS EC2 Instances in Private Subnets
resource "aws_instance" "ecs_instances" {
  count = 2

  ami                    = "ami-0077a350292f081f3" # Amazon ECS-optimized AMI (Update for your region)
  instance_type          = var.instance_type
  iam_instance_profile   = aws_iam_instance_profile.ecs_instance_profile.name
  subnet_id              = var.private_subnets[count.index]
  key_name               = var.bastion_key_name
  vpc_security_group_ids = [aws_security_group.ecs_sg.id]

  user_data = base64encode(<<-EOF
              #!/bin/bash
              echo "ECS_CLUSTER=${var.cluster_name}" >> /etc/ecs/ecs.config
              systemctl start ecs
              EOF
  )

  tags = {
    Name = "${var.cluster_name}-instance-${count.index + 1}"
  }
}

# ECS Task Definition
  resource "aws_ecs_task_definition" "this" {
    family                   = "${var.cluster_name}-task"
    network_mode             = "bridge"
    requires_compatibilities = ["EC2"]
    execution_role_arn       = aws_iam_role.ecs_instance_role.arn
    cpu                      = "256"
    memory                   = "512"

    container_definitions = jsonencode([{
      name      = "app-container"
      image     = var.container_image
      cpu       = 256
      memory    = 512
      essential = true
      portMappings = [{
        containerPort = 5000
        hostPort      = 5000
      }]
    }])
  }

# ECS Service
resource "aws_ecs_service" "this" {
  name            = "${var.cluster_name}-service"
  cluster         = aws_ecs_cluster.this.id
  task_definition = aws_ecs_task_definition.this.arn
  desired_count   = 2
  launch_type     = "EC2"

  load_balancer {
    target_group_arn = var.alb_target_group_arn
    container_name   = "app-container"
    container_port   = 5000
  }
}
