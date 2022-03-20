data "aws_subnet" "alpha" {
  filter {
    name   = "tag:Name"
    values = ["Default Public 1a"]
  }
}

data "aws_subnet" "beta" {
  filter {
    name   = "tag:Name"
    values = ["Default Public 1b"]
  }
}

data "aws_subnet" "charlie" {
  filter {
    name   = "tag:Name"
    values = ["Default Public 1c"]
  }
}

resource "aws_efs_file_system" "foo" {
  creation_token = "my-product"
}

resource "aws_efs_mount_target" "alpha" {
  file_system_id  = aws_efs_file_system.foo.id
  subnet_id       = data.aws_subnet.alpha.id
  security_groups = [aws_security_group.my-efs-demo.id]
}

resource "aws_efs_mount_target" "beta" {
  file_system_id  = aws_efs_file_system.foo.id
  subnet_id       = data.aws_subnet.beta.id
  security_groups = [aws_security_group.my-efs-demo.id]
}

resource "aws_efs_mount_target" "charlie" {
  file_system_id  = aws_efs_file_system.foo.id
  subnet_id       = data.aws_subnet.charlie.id
  security_groups = [aws_security_group.my-efs-demo.id]
}
