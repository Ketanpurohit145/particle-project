# Create Security Group for ALB
resource "aws_security_group" "alb_sg" {
  name_prefix = "${var.alb_name}-sg"
  vpc_id      = var.vpc_id

  # Allow HTTP traffic from anywhere (Modify for more restrictions)
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow all outgoing traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.alb_name}-sg"
  }
}

# Create ALB in Public Subnets
resource "aws_lb" "this" {
  name               = var.alb_name
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = var.public_subnets

  tags = {
    Name = var.alb_name
  }
}

# Create Target Group for ECS
resource "aws_lb_target_group" "ecs_tg" {
  name        = var.ecs_tg_name
  port        = 5000
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "instance"  # Targets EC2 instances (Not Fargate)

  health_check {
    path                = "/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 3
  }

  tags = {
    Name = var.ecs_tg_name
  }
}

# Create ALB Listener to Forward Traffic to ECS
resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.this.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ecs_tg.arn
  }
}
