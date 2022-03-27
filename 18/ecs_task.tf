data "aws_subnets" "singapore" {
  filter {
    name   = "tag:Name"
    values = ["Default Public a", "Default Public b", "Default Public c"]
  }
}

resource "aws_ecs_task_definition" "test" {
  family                   = "first-run-task-definition"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = 256
  memory                   = 512

  container_definitions = jsonencode([
    {
      "name" : "sample-app",
      "image" : "https:2.4",
      "cpu" : 256,
      "memory" : 512,
      "essential" : true
    }
  ])
}

resource "aws_ecs_service" "sample" {
  name            = "sample-app-service"
  cluster         = aws_ecs_cluster.foo.id
  task_definition = aws_ecs_task_definition.test.arn
  desired_count   = 1

  network_configuration {
    subnets = tolist(data.aws_subnets.singapore.ids)
  }
}

resource "aws_ecs_cluster" "foo" {
  name = "demo-jgyy-fargate"
}
