resource "aws_iam_user_policy_attachment" "user" {
  user       = aws_iam_user.stephane.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonGlacierReadOnlyAccess"
}

resource "aws_iam_group_policy_attachment" "admin" {
  group      = aws_iam_group.admin.name
  policy_arn = "arn:aws:iam::aws:policy/AWSDirectConnectReadOnlyAccess"
}

resource "aws_iam_group_policy_attachment" "developer" {
  group      = aws_iam_group.developer.name
  policy_arn = "arn:aws:iam::aws:policy/AWSIoT1ClickReadOnlyAccess"
}