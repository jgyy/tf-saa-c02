resource "aws_iam_role" "replication" {
  name = "tf-iam-role-replication-12345"
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Action" : "sts:AssumeRole",
        "Principal" : { "Service" : "s3.amazonaws.com" },
        "Effect" : "Allow",
        "Sid" : ""
      }
    ]
  })
}

resource "aws_iam_policy" "replication" {
  name = "tf-iam-role-policy-replication-12345"
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Action" : [
          "s3:GetReplicationConfiguration",
          "s3:ListBucket"
        ],
        "Effect" : "Allow",
        "Resource" : ["${aws_s3_bucket.source.arn}"]
      },
      {
        "Action" : [
          "s3:GetObjectVersionForReplication",
          "s3:GetObjectVersionAcl",
          "s3:GetObjectVersionTagging"
        ],
        "Effect" : "Allow",
        "Resource" : ["${aws_s3_bucket.source.arn}/*"]
      },
      {
        "Action" : [
          "s3:ReplicateObject",
          "s3:ReplicateDelete",
          "s3:ReplicateTags"
        ],
        "Effect" : "Allow",
        "Resource" : "${aws_s3_bucket.destination.arn}/*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "replication" {
  role       = aws_iam_role.replication.name
  policy_arn = aws_iam_policy.replication.arn
}
