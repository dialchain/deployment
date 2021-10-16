//data "aws_caller_identity" "current" {}

locals {
  region    = var.region
  log_group = aws_cloudwatch_log_group.this.name
}

resource "aws_ecs_cluster" "this" {
  name = "${lower(var.prefix)}-ECSCluster"

  tags = {
    Name = "${lower(var.prefix)}-ecs-fargate-cluster"
  }
}

resource "aws_ecs_task_definition" "this" {
  family                   = "${lower(var.prefix)}-ECSTaskDefinition"
  task_role_arn            = aws_iam_role.ecs_task_execution_role.arn
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "1024"
  memory                   = "2048"
  container_definitions    = <<DEFINITION
[
  {
    "logConfiguration": {
          "logDriver": "awslogs",
          "options": {
            "awslogs-group": "${local.log_group}",
            "awslogs-region": "${local.region}",
            "awslogs-stream-prefix": "/aws/ecs"
          }
        },
    "cpu":512,
    "memory": 1024,
    "memoryReservation": 1024,
    "dnsSearchDomains":[],
    "dnsServers":[],
    "dockerLabels":{},
    "dockerSecurityOptions":[],
    "essential":true,
    "extraHosts":[],
    "image": "${lower(var.container-image)}",
    "links":[],
    "mountPoints":[],
    "name": "${lower(var.container-name)}",
    "portMappings":[
      {
        "containerPort": ${var.container-port},
        "hostPort": ${var.host-port},
        "protocol": "tcp"
      }
    ],
    "ulimits":[],
    "volumesFrom":[],
    "environment": [
      {"name": "APP_PORT", "value": "9092"}
    ]
  }
]
DEFINITION
}

resource "aws_ecs_service" "this" {
  name                               = "${lower(var.prefix)}-service"
  cluster                            = aws_ecs_cluster.this.name
  task_definition                    = aws_ecs_task_definition.this.arn
  desired_count                      = 1
  deployment_minimum_healthy_percent = 50
  deployment_maximum_percent         = 200
  launch_type                        = "FARGATE"
  scheduling_strategy                = "REPLICA"

  network_configuration {
    security_groups  = [aws_security_group.this.id]
    subnets          = [aws_subnet.this.id]
    assign_public_ip = true
  }

  lifecycle {
    ignore_changes = [task_definition, desired_count]
  }
}