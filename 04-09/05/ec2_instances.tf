data "aws_ami" "amazon-linux-2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
}

resource "aws_instance" "web" {
  ami                    = data.aws_ami.amazon-linux-2.id
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.allow_http.id]
  user_data              = file("ec2-user-data.sh")
  key_name               = aws_key_pair.ec2.id
  iam_instance_profile = aws_iam_role.ec2_role.id
  tags = {
    "Name"       = "My First Instance"
    "Department" = "Finance"
  }
}

resource "aws_key_pair" "ec2" {
  key_name   = "ec2"
  public_key = file("/tmp/ec2.pub")
}

resource "time_sleep" "wait_2_minutes" {
  create_duration = "120s"
}