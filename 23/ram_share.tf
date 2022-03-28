resource "aws_ram_resource_share" "example" {
  name                      = "MyFirstResourceshare"
  allow_external_principals = true
}