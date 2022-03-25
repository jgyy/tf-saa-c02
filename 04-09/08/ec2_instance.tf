data "aws_ami" "amazon-linux-2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
}

resource "aws_key_pair" "ec2" {
  key_name   = "ec2"
  public_key = file("/tmp/ec2.pub")
}

resource "aws_instance" "web1" {
  ami                    = data.aws_ami.amazon-linux-2.id
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.ec2.id
  vpc_security_group_ids = [aws_security_group.ec2.id]
  user_data              = file("ec2_user_data.sh")
}

resource "aws_instance" "web2" {
  ami                    = data.aws_ami.amazon-linux-2.id
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.ec2.id
  vpc_security_group_ids = [aws_security_group.ec2.id]
  user_data              = file("ec2_user_data.sh")
}

resource "aws_instance" "web3" {
  ami                    = data.aws_ami.amazon-linux-2.id
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.ec2.id
  vpc_security_group_ids = [aws_security_group.ec2.id]
  user_data              = file("ec2_user_data.sh")
}
