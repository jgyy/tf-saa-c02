resource "aws_egress_only_internet_gateway" "example" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "DemoEGIW"
  }
}
