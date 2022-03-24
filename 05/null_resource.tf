resource "null_resource" "url" {
  provisioner "local-exec" {
    command = "sleep 64; curl -s http://${aws_instance.web.public_ip}"
  }
}
