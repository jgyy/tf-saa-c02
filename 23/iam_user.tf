resource "aws_iam_user" "lb" {
  name                 = "john"
  permissions_boundary = aws_iam_policy.boundary.arn
}

resource "aws_iam_access_key" "lb" {
  user = aws_iam_user.lb.name
}

resource "aws_iam_user_policy" "lb_ro" {
  name = "test"
  user = aws_iam_user.lb.name

  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Action" : [
          "ec2:Describe*"
        ],
        "Effect" : "Allow",
        "Resource" : "*"
      }
    ]
  })
}

resource "aws_iam_policy" "boundary" {
  name = "boundary"

  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Action" : [
          "ec2:*",
          "s3:*"
        ],
        "Effect" : "Allow",
        "Resource" : "*"
      }
    ]
  })
}
