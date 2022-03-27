variable "myregion" {
  default = "ap-southeast-1"
}

data "aws_caller_identity" "current" {}

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

resource "aws_lambda_function" "lambda" {
  function_name    = "lambda-root"
  role             = aws_iam_role.iam_for_lambda.arn
  handler          = "lambda.lambda_handler"
  filename         = "lambda_function_payload.zip"
  source_code_hash = filebase64sha256("${path.module}/lambda_function_payload.zip")
  runtime          = "python3.8"
}

resource "aws_lambda_permission" "apigw_root" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn = join("", [
    "arn:aws:execute-api:${var.myregion}:",
    "${data.aws_caller_identity.current.account_id}:${aws_api_gateway_rest_api.example.id}/*/",
    "${aws_api_gateway_method.method-root.http_method}/"
  ])
}

resource "aws_lambda_function" "lambda2" {
  function_name    = "lambda-houses"
  role             = aws_iam_role.iam_for_lambda.arn
  handler          = "lambda.lambda_handler"
  filename         = "lambda_function_payload.zip"
  source_code_hash = filebase64sha256("${path.module}/lambda_function_payload.zip")
  runtime          = "python3.8"
}

resource "aws_lambda_permission" "apigw_house" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda2.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn = join("", [
    "arn:aws:execute-api:${var.myregion}:",
    "${data.aws_caller_identity.current.account_id}:${aws_api_gateway_rest_api.example.id}/*/",
    "${aws_api_gateway_method.house.http_method}",
    "${aws_api_gateway_resource.house.path}"
  ])
}