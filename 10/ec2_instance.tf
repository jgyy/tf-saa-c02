# SINGAPORE
resource "aws_key_pair" "singapore" {
  provider   = aws.singapore
  key_name   = "ec2"
  public_key = file("/tmp/ec2.pub")
}

resource "aws_instance" "singapore" {
  provider               = aws.singapore
  ami                    = data.aws_ami.singapore.id
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.singapore.id
  vpc_security_group_ids = [aws_security_group.singapore.id]
  user_data              = file("${path.module}/ec2_user_data.sh")
}

# SYDNEY
resource "aws_key_pair" "sydney" {
  provider   = aws.sydney
  key_name   = "ec2"
  public_key = file("/tmp/ec2.pub")
}

resource "aws_instance" "sydney" {
  provider               = aws.sydney
  ami                    = data.aws_ami.sydney.id
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.sydney.id
  vpc_security_group_ids = [aws_security_group.sydney.id]
  user_data              = file("${path.module}/ec2_user_data.sh")
}

# TOKYO
resource "aws_key_pair" "tokyo" {
  provider   = aws.tokyo
  key_name   = "ec2"
  public_key = file("/tmp/ec2.pub")
}

resource "aws_instance" "tokyo" {
  provider               = aws.tokyo
  ami                    = data.aws_ami.tokyo.id
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.tokyo.id
  vpc_security_group_ids = [aws_security_group.tokyo.id]
  user_data              = file("${path.module}/ec2_user_data.sh")
}
