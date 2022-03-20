resource "aws_placement_group" "performance" {
  name     = "performance"
  strategy = "cluster"
}

resource "aws_placement_group" "critical" {
  name     = "critical"
  strategy = "spread"
}

resource "aws_placement_group" "distribute" {
  name            = "distribute"
  strategy        = "partition"
  partition_count = 7
}
