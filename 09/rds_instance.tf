data "aws_subnets" "public" {
  filter {
    name   = "tag:Name"
    values = ["Default Public 1a", "Default Public 1b", "Default Public 1c"]
  }
}

resource "aws_db_instance" "mysql" {
  allocated_storage       = 20
  max_allocated_storage   = 1000
  port                    = 3306
  engine                  = "mysql"
  engine_version          = "8.0.23"
  instance_class          = "db.t2.micro"
  identifier              = "database-1"
  name                    = "mydb"
  username                = "admin"
  password                = "password"
  parameter_group_name    = "default.mysql8.0"
  option_group_name       = "default:mysql-8-0"
  backup_retention_period = 7
  db_subnet_group_name    = aws_db_subnet_group.default-public.id
  vpc_security_group_ids  = [aws_security_group.rds.id]
  skip_final_snapshot     = true
  publicly_accessible     = true
  multi_az                = false
}

resource "aws_db_subnet_group" "default-public" {
  name       = "default-public"
  subnet_ids = [for subnet in data.aws_subnets.public.ids : subnet]

  tags = {
    Name = "My DB subnet group"
  }
}
