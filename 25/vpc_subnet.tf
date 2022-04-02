resource "aws_subnet" "publica" {
  vpc_id                          = aws_vpc.main.id
  cidr_block                      = cidrsubnet(aws_vpc.main.cidr_block, 8, 1)
  ipv6_cidr_block                 = cidrsubnet(aws_vpc.main.ipv6_cidr_block, 8, 1)
  availability_zone               = "ap-southeast-1a"
  map_public_ip_on_launch         = true
  assign_ipv6_address_on_creation = true
  tags = {
    Name = "PublicSubnetA"
  }
}

resource "aws_subnet" "publicb" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = cidrsubnet(aws_vpc.main.cidr_block, 8, 2)
  ipv6_cidr_block         = cidrsubnet(aws_vpc.main.ipv6_cidr_block, 8, 2)
  availability_zone       = "ap-southeast-1b"
  map_public_ip_on_launch = true
  tags = {
    Name = "PublicSubnetB"
  }
}

resource "aws_subnet" "publicc" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = cidrsubnet(aws_vpc.main.cidr_block, 8, 3)
  ipv6_cidr_block         = cidrsubnet(aws_vpc.main.ipv6_cidr_block, 8, 3)
  availability_zone       = "ap-southeast-1c"
  map_public_ip_on_launch = true
  tags = {
    Name = "PublicSubnetC"
  }
}

resource "aws_subnet" "privatea" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = cidrsubnet(aws_vpc.main.cidr_block, 8, 4)
  ipv6_cidr_block   = cidrsubnet(aws_vpc.main.ipv6_cidr_block, 8, 4)
  availability_zone = "ap-southeast-1a"
  tags = {
    Name = "PrivateSubnetA"
  }
}

resource "aws_subnet" "privateb" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = cidrsubnet(aws_vpc.main.cidr_block, 8, 5)
  ipv6_cidr_block   = cidrsubnet(aws_vpc.main.ipv6_cidr_block, 8, 5)
  availability_zone = "ap-southeast-1b"
  tags = {
    Name = "PrivateSubnetB"
  }
}

resource "aws_subnet" "privatec" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = cidrsubnet(aws_vpc.main.cidr_block, 8, 6)
  ipv6_cidr_block   = cidrsubnet(aws_vpc.main.ipv6_cidr_block, 8, 6)
  availability_zone = "ap-southeast-1c"
  tags = {
    Name = "PrivateSubnetC"
  }
}
