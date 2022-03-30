resource "aws_iam_role" "iam_for_lambda" {
  name = "iam_for_lambda"
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Action" : "sts:AssumeRole",
        "Principal" : {
          "Service" : "lambda.amazonaws.com"
        },
        "Effect" : "Allow",
        "Sid" : ""
      }
    ]
  })
}

resource "aws_iam_policy" "lambda_logging" {
  name        = "lambda_logging"
  path        = "/"
  description = "IAM policy for logging from a lambda"

  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Action" : [
          "ssm:*",
          "kms:*"
        ],
        "Resource" : "*",
        "Effect" : "Allow"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_logs" {
  role       = aws_iam_role.iam_for_lambda.name
  policy_arn = aws_iam_policy.lambda_logging.arn
}

resource "aws_lambda_function" "test" {
  filename         = "lambda_function_payload.zip"
  function_name    = "hello-world-ssm"
  role             = aws_iam_role.iam_for_lambda.arn
  handler          = "lambda.lambda_handler"
  source_code_hash = filebase64sha256("lambda_function_payload.zip")
  runtime          = "python3.7"

  environment {
    variables = {
      DEV_OR_PROD = "dev"
    }
  }
}

resource "aws_lambda_invocation" "example" {
  function_name = aws_lambda_function.test.function_name

  input = jsonencode({
    key1 = "value1"
    key2 = "value2"
  })
}

output "result_entry" {
  value = jsondecode(aws_lambda_invocation.example.result)
}
