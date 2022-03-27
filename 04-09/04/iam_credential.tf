resource "null_resource" "credential" {
  provisioner "local-exec" {
    command = join(" ", [
      "aws iam generate-credential-report > /dev/null;",
      "aws iam get-credential-report | head -n 1 | cut -d \" \" -f 2 | base64 -d;"
    ])
  }
}
