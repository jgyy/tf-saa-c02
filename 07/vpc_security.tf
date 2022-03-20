data "aws_vpc" "default" {
  filter {
    name   = "tag:Name"
    values = ["Default VPC"]
  }
}

resource "aws_security_group" "ec2-to-efs" {
  name        = "ec2-to-efs"
  description = "Allow TLS inbound traffic"
}

resource "aws_security_group" "my-efs-demo" {
  name        = "my-efs-demo"
  description = "Security group for EFS"
}

resource "aws_security_group_rule" "ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.ec2-to-efs.id
}

resource "aws_security_group_rule" "efs" {
  type                     = "ingress"
  from_port                = 2049
  to_port                  = 2049
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.ec2-to-efs.id
  security_group_id        = aws_security_group.my-efs-demo.id
}

resource "aws_security_group_rule" "egress-ec2" {
  type              = "egress"
  from_port         = 0
  to_port           = 65535
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.ec2-to-efs.id
}

resource "aws_security_group_rule" "egress-efs" {
  type              = "egress"
  from_port         = 0
  to_port           = 65535
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.my-efs-demo.id
}
