data "aws_ami" "amazon-linux-2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
}

resource "aws_ami_from_instance" "demo-image" {
  name               = "DemoImage"
  source_instance_id = aws_instance.web.id
}

resource "aws_instance" "web" {
  ami                    = data.aws_ami.amazon-linux-2.id
  instance_type          = "t2.micro"
  availability_zone      = "ap-southeast-1a"
  key_name               = aws_key_pair.ec2.id
  vpc_security_group_ids = [aws_security_group.ec2-to-efs.id]

  user_data = templatefile(
    "ec2_user_data.sh",
    { filesystem = aws_efs_file_system.foo.id }
  )

  tags = {
    Name = "Initial Image"
  }
}

resource "aws_instance" "custom-ami" {
  ami                    = aws_ami_from_instance.demo-image.id
  instance_type          = "t2.micro"
  availability_zone      = "ap-southeast-1b"
  key_name               = aws_key_pair.ec2.id
  vpc_security_group_ids = [aws_security_group.ec2-to-efs.id]

  user_data = templatefile(
    "ec2_user_data.sh",
    { filesystem = aws_efs_file_system.foo.id }
  )

  tags = {
    Name = "From AMI"
  }
}

resource "aws_key_pair" "ec2" {
  key_name   = "ec2"
  public_key = file("/tmp/ec2.pub")
}
