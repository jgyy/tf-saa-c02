data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_key_pair" "deployer" {
  key_name   = "ec2"
  public_key = file("/tmp/ec2.pub")
}

resource "aws_instance" "bastion" {
  ami             = data.aws_ami.ubuntu.id
  instance_type   = "t2.micro"
  subnet_id       = aws_subnet.publica.id
  security_groups = [aws_security_group.public.id]
  key_name        = aws_key_pair.deployer.id
  user_data       = file("ec2-user-data.sh")
  tags = {
    Name = "BastionHost"
  }
}

resource "aws_instance" "private" {
  ami             = data.aws_ami.ubuntu.id
  instance_type   = "t2.micro"
  subnet_id       = aws_subnet.privatea.id
  security_groups = [aws_security_group.private.id]
  key_name        = aws_key_pair.deployer.id
  depends_on      = [time_sleep.wait_1_minute]
  tags = {
    Name = "PrivateInstance"
  }
}

resource "aws_instance" "default" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.default.id]
  key_name               = aws_key_pair.deployer.id
  tags = {
    Name = "DefaultVPCInstance"
  }
}

resource "time_sleep" "wait_1_minute" {
  create_duration = "64s"
}
