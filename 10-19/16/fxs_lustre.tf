resource "aws_fsx_lustre_file_system" "example" {
  import_path      = "s3://${aws_s3_bucket.b.bucket}"
  storage_capacity = 1200
  subnet_ids       = [tolist(data.aws_subnets.singapore.ids)[0]]
}

resource "aws_s3_bucket" "b" {
  bucket = "my-tf-test-bucket-jgyy"
}
