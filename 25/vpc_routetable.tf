resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
  route {
    cidr_block                = data.aws_vpc.default.cidr_block
    vpc_peering_connection_id = aws_vpc_peering_connection.foo.id
  }
  tags = {
    Name = "PublicRouteTable"
  }
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id
  route {
    ipv6_cidr_block        = "::/0"
    egress_only_gateway_id = aws_egress_only_internet_gateway.example.id
  }
  tags = {
    Name = "PrivateRouteTable"
  }
}

resource "aws_route_table_association" "publica" {
  subnet_id      = aws_subnet.publica.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "publicb" {
  subnet_id      = aws_subnet.publicb.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "publicc" {
  subnet_id      = aws_subnet.publicc.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "privatea" {
  subnet_id      = aws_subnet.privatea.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "privateb" {
  subnet_id      = aws_subnet.privateb.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "privatec" {
  subnet_id      = aws_subnet.privatec.id
  route_table_id = aws_route_table.private.id
}
