# SINGAPORE
data "aws_ami" "singapore" {
  provider    = aws.singapore
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
}

data "aws_vpc" "singapore" {
  provider = aws.singapore
  filter {
    name   = "tag:Name"
    values = ["Default"]
  }
}

data "aws_subnets" "singapore" {
  provider = aws.singapore
  filter {
    name   = "tag:Name"
    values = ["Default Public a", "Default Public b", "Default Public c"]
  }
}

# SYDNEY
data "aws_ami" "sydney" {
  provider    = aws.sydney
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
}

data "aws_vpc" "sydney" {
  provider = aws.sydney
  filter {
    name   = "tag:Name"
    values = ["Default"]
  }
}

data "aws_subnets" "sydney" {
  provider = aws.sydney
  filter {
    name   = "tag:Name"
    values = ["Default Public a", "Default Public b", "Default Public c"]
  }
}

# TOKYO
data "aws_ami" "tokyo" {
  provider    = aws.tokyo
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
}

data "aws_vpc" "tokyo" {
  provider = aws.tokyo
  filter {
    name   = "tag:Name"
    values = ["Default"]
  }
}

data "aws_subnets" "tokyo" {
  provider = aws.tokyo
  filter {
    name   = "tag:Name"
    values = ["Default Public a", "Default Public b", "Default Public c"]
  }
}
