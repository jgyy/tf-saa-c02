resource "aws_nat_gateway" "example" {
  allocation_id = aws_eip.lb.id
  subnet_id     = aws_subnet.publica.id

  tags = {
    Name = "DemoNATGW"
  }
  depends_on = [aws_internet_gateway.gw]
}

resource "aws_eip" "lb" {
  vpc = true
}
