resource "aws_elasticache_cluster" "redis" {
  cluster_id               = "my-first-redis"
  engine                   = "redis"
  node_type                = "cache.t2.micro"
  parameter_group_name     = "default.redis5.0"
  engine_version           = "5.0.6"
  subnet_group_name        = aws_elasticache_subnet_group.bar.id
  port                     = 6379
  snapshot_retention_limit = 1
  num_cache_nodes          = 1
}

resource "aws_elasticache_subnet_group" "bar" {
  name       = "tf-test-cache-subnet"
  subnet_ids = [for subnet in data.aws_subnets.public.ids : subnet]
}
