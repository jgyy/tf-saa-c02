data "aws_subnets" "private" {
  filter {
    name   = "tag:Name"
    values = ["Default Private 1a", "Default Private 1b", "Default Private 1c"]
  }
}

resource "aws_rds_cluster" "default" {
  cluster_identifier        = "aurora-cluster-demo"
  engine                    = "aurora-mysql"
  engine_version            = "5.7.mysql_aurora.2.10.1"
  availability_zones        = ["ap-southeast-1a", "ap-southeast-1b", "ap-southeast-1c"]
  database_name             = "mydb"
  master_username           = "admin"
  master_password           = "password"
  backup_retention_period   = 1
  port                      = 3306
  db_subnet_group_name      = aws_db_subnet_group.default-private.id
  storage_encrypted         = true
  skip_final_snapshot       = true
}

resource "aws_db_subnet_group" "default-private" {
  name       = "default-private"
  subnet_ids = [for subnet in data.aws_subnets.private.ids : subnet]

  tags = {
    Name = "My DB subnet group"
  }
}
