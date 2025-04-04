resource "aws_cloudwatch_event_rule" "reset_weekly_schedule" {
  name                = "reset_weekly_counter_rule"
  schedule_expression = "cron(0 0 ? * MON *)"
}

resource "aws_cloudwatch_event_target" "reset_weekly_target" {
  rule      = aws_cloudwatch_event_rule.reset_weekly_schedule.name
  target_id = "resetWeekly"
  arn       = aws_lambda_function.reset_weekly_lambda.arn
}