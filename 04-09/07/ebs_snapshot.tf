resource "aws_ebs_snapshot" "demo_snapshot" {
  description = "Demo Snapshot"
  volume_id   = aws_ebs_volume.az1.id
}

resource "aws_ebs_volume" "snapshot" {
  availability_zone = "ap-southeast-1b"
  size              = 2
  type              = "gp2"
  snapshot_id       = aws_ebs_snapshot.demo_snapshot.id

  tags = {
    Name = "Restored Volume"
  }
}

resource "aws_ebs_snapshot_copy" "encrypt" {
  source_snapshot_id = aws_ebs_snapshot.demo_snapshot.id
  source_region      = "ap-southeast-1"
  encrypted          = true
}

resource "aws_ebs_volume" "encrypt_snapshot" {
  availability_zone = "ap-southeast-1b"
  size              = 2
  type              = "gp2"
  snapshot_id       = aws_ebs_snapshot_copy.encrypt.id
}

resource "aws_ebs_volume" "encrypt_volume" {
  availability_zone = "ap-southeast-1b"
  size              = 2
  type              = "gp2"
  snapshot_id       = aws_ebs_snapshot_copy.encrypt.id
  encrypted         = true
}
