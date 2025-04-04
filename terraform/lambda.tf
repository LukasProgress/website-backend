// Visitor counter:
resource "aws_lambda_function" "visitor_counter_lambda" {
  filename      = "../lambda/visitor_counter.zip"
  function_name = "visitor_counter"
  role          = aws_iam_role.lambda_exec_role.arn
  handler       = "visitor_counter.lambda_handler"
  runtime       = "python3.11"

  source_code_hash = filebase64sha256("../lambda/visitor_counter.zip")
}

resource "aws_lambda_permission" "allow_apigw" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.visitor_counter_lambda.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_apigatewayv2_api.http_api.execution_arn}/*/*"
}

// Reset function:

resource "aws_lambda_function" "reset_weekly_lambda" {
  filename         = "../lambda/reset_weekly_counter.zip"
  function_name    = "reset_weekly_counter"
  handler          = "reset_weekly_counter.lambda_handler"
  runtime          = "python3.11"
  role             = aws_iam_role.lambda_exec_role.arn
  source_code_hash = filebase64sha256("../lambda/reset_weekly_counter.zip")
}

resource "aws_lambda_permission" "allow_eventrbridge_call" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.reset_weekly_lambda.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.reset_weekly_schedule.arn
}
