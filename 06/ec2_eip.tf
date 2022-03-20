resource "aws_eip" "eip" {
  vpc = true
}

resource "aws_eip_association" "eip_assoc" {
  instance_id        = aws_instance.web.id
  allocation_id      = aws_eip.eip.id
  private_ip_address = aws_instance.web.private_ip
}
