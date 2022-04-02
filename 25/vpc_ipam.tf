resource "aws_vpc_ipam" "example" {
  operating_regions {
    region_name = "ap-southeast-1"
  }
}

resource "aws_vpc_ipam_pool" "ipv6" {
  address_family = "ipv6"
  ipam_scope_id  = aws_vpc_ipam.example.public_default_scope_id
  locale         = "ap-southeast-1"
  description    = "public ipv6"
  aws_service    = "ec2"
}
