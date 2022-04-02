data "aws_ami" "nat" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn-ami-vpc-nat*"]
  }
}

resource "aws_instance" "nat" {
  ami               = data.aws_ami.nat.id
  instance_type     = "t2.micro"
  subnet_id         = aws_subnet.publica.id
  security_groups   = [aws_security_group.public.id]
  key_name          = aws_key_pair.deployer.id
  source_dest_check = false
  tags = {
    Name = "NAT Instance"
  }
}
