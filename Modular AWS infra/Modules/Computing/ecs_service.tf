# - ECS service
# - Desired count
# - Deployment controller
# - Load balancer integration
# - Service‑level networking (subnets, SGs)
# This is the runtime logic.
resource "aws_ecs_service" "this" {
  name            = "${var.project}-${var.environment}-${var.service_name}"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.this.arn
  desired_count   = var.desired_count
  launch_type     = "FARGATE"

  network_configuration {
    subnets = [
      aws_subnet.first_private_subnet.id,
      aws_subnet.second_private_subnet.id
    ]

    security_groups  = [aws_security_group.ecs_tasks.id]
    assign_public_ip = false
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.this.arn
    container_name   = var.service_name
    container_port   = 80
  }

  deployment_minimum_healthy_percent = 50
  deployment_maximum_percent         = 200

  depends_on = [
    aws_lb_listener.http
  ]
}