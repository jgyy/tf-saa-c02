resource "aws_ebs_volume" "az1" {
  availability_zone = "ap-southeast-1a"
  size              = 2
  type              = "gp2"
}

resource "aws_volume_attachment" "ebs_att" {
  device_name                    = "/dev/sdf"
  volume_id                      = aws_ebs_volume.az1.id
  instance_id                    = aws_instance.web.id
  force_detach                   = true
  stop_instance_before_detaching = true
}
