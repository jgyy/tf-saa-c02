data "aws_organizations_organization" "org" {}

resource "aws_organizations_policy" "example" {
  name = "FullAccess"

  content = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : {
      "Effect" : "Allow",
      "Action" : "*",
      "Resource" : "*"
    }
  })
}

resource "aws_organizations_policy_attachment" "root" {
  policy_id = aws_organizations_policy.example.id
  target_id = data.aws_organizations_organization.org.roots[0].id
}

resource "aws_organizations_organizational_unit" "dev" {
  name      = "Dev"
  parent_id = data.aws_organizations_organization.org.roots[0].id
}

resource "aws_organizations_organizational_unit" "test" {
  name      = "Test"
  parent_id = data.aws_organizations_organization.org.roots[0].id
}

resource "aws_organizations_organizational_unit" "prod" {
  name      = "Prod"
  parent_id = data.aws_organizations_organization.org.roots[0].id
}

resource "aws_organizations_organizational_unit" "finance" {
  name      = "Finance"
  parent_id = aws_organizations_organizational_unit.prod.id
}

resource "aws_organizations_organizational_unit" "hr" {
  name      = "HR"
  parent_id = aws_organizations_organizational_unit.prod.id
}
