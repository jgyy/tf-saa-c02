data "aws_vpc" "default" {
  filter {
    name   = "tag:Name"
    values = ["Default"]
  }
}

resource "aws_vpc_peering_connection" "foo" {
  peer_vpc_id = data.aws_vpc.default.id
  vpc_id      = aws_vpc.main.id
  auto_accept = true
  tags = {
    "Name" = "DemoPeeringConnection"
  }
}
