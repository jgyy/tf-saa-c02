data "aws_ssoadmin_instances" "example" {}

resource "aws_ssoadmin_permission_set" "example" {
  name             = "Example"
  description      = "An example"
  instance_arn     = tolist(data.aws_ssoadmin_instances.example.arns)[0]
  relay_state      = "https://s3.console.aws.amazon.com/s3/home?region=ap-southeast-1#"
  session_duration = "PT2H"
}
