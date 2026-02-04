# 2. ecs_task_definition.tf
# - Task definition
# - Container definitions (JSONencode block)
# - Logging configuration
# - CPU/memory
# - Image reference (ECR)
# This file becomes your “container blueprint.

resource "aws_ecs_task_definition" "this" {
  family                   = "${var.project}-${var.environment}-${var.service_name}"
  network_mode             = "awsvpc" #Each ECS task gets its own ENI (Elastic Network Interface) with its own private ip. 
  requires_compatibilities = ["FARGATE"] #Tells ECS that this task definition is designed to run on Fargate (serverless).
  cpu                      = var.cpu
  memory                   = var.memory
  execution_role_arn       = aws_iam_role.ecs_execution_role.arn #lets ECS pull images, write logs
  task_role_arn            = aws_iam_role.ecs_task_role.arn #permissions inside the container

  container_definitions = jsonencode([
    {
      name      = var.service_name
      image     = var.image
      essential = true

      portMappings = [
        {
          containerPort = 80
          protocol      = "tcp"
        }
      ]

      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = "/ecs/${var.project}-${var.environment}-${var.service_name}"
          awslogs-region        = data.aws_region.current.name
          awslogs-stream-prefix = "ecs"
        }
      }
    }
  ])
}