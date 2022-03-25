resource "aws_iam_user" "stephane" {
  name = "stephane"
  tags = {
    Department = "Engineer"
  }
}

resource "aws_iam_group" "admin" {
  name = "admin"
}

resource "aws_iam_group" "developer" {
  name = "developer"
}

resource "aws_iam_group_membership" "admin" {
  name  = "admin"
  group = aws_iam_group.admin.name
  users = [aws_iam_user.stephane.name]
}

resource "aws_iam_group_membership" "developer" {
  name  = "developer"
  group = aws_iam_group.developer.name
  users = [aws_iam_user.stephane.name]
}