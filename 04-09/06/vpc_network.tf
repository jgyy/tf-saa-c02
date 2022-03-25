data "aws_subnet" "selected" {
  filter {
    name   = "tag:Name"
    values = ["Default Public 1a"]
  }
}

data "aws_vpc" "selected" {
  filter {
    name   = "tag:Name"
    values = ["Default VPC"]
  }
}

resource "aws_network_interface" "test" {
  description     = "test"
  subnet_id       = data.aws_subnet.selected.id
  security_groups = [aws_security_group.allow_all.id]

}

resource "aws_network_interface_attachment" "test" {
  instance_id          = aws_instance.web.id
  network_interface_id = aws_network_interface.test.id
  device_index         = 1
}

resource "aws_security_group" "allow_all" {
  name        = "allow_all"
  description = "Allow TLS inbound traffic"
}

resource "aws_security_group_rule" "ingress" {
  type              = "ingress"
  from_port         = 0
  to_port           = 65535
  protocol          = "tcp"
  cidr_blocks       = [data.aws_vpc.selected.cidr_block]
  security_group_id = aws_security_group.allow_all.id
}

resource "aws_security_group_rule" "egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 65535
  protocol          = "tcp"
  cidr_blocks       = [data.aws_vpc.selected.cidr_block]
  security_group_id = aws_security_group.allow_all.id
}
