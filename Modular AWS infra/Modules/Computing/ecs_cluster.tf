# - ECS cluster resource
# - CloudWatch container insights (optional)
# - Tags
# This keeps the cluster logic isolated.


#The ECS cluster is is a logical container that does no compute, no networking . Its just a folder for the services
resource "aws_ecs_cluster" "main" {
  name = "my-ecs-cluster"
}

#A capacity provider is the bridge between the ECS and Fargate which tell ECS what to use (in my case is Faragate)
resource "aws_ecs_cluster_capacity_providers" "main" {
  cluster_name = aws_ecs_cluster.main.name

  capacity_providers = ["FARGATE"]

  default_capacity_provider_strategy {
    capacity_provider = "FARGATE"
    weight            = 1
    base              = 1
  }
}