resource "aws_cloudwatch_event_rule" "console" {
  name        = "stopEC2_Allinstances"
  description = "StopEC2_Allinstances"
  schedule_expression = "cron(0 21 * * ? *)"
}

resource "aws_cloudwatch_event_target" "Stopping_Ec2_Instances" {
    rule = "${aws_cloudwatch_event_rule.console.name}"
    target_id = "lambda_for_stop"
    arn = "${aws_lambda_function.lambda_for_stop.arn}"
}

/*resource "aws_cloudwatch_event_rule" "console_1" {
  name        = "start_instances"
  description = "start_instances (For GIT SERVER)"
  schedule_expression = "cron(30 16 * * ? *)"
}

resource "aws_cloudwatch_event_target" "Starting_Ec2_Instances" {
    rule = "${aws_cloudwatch_event_rule.console_1.name}"
    target_id = "test_lambda_1"
    arn = "${aws_lambda_function.test_lambda_1.arn}"
}*/

resource "aws_lambda_permission" "allow_cloudwatch_to_call_test_lambda_function_Stop" {
    statement_id = "AllowExecutionFromCloudWatch"
    action = "lambda:InvokeFunction"
    function_name = "${aws_lambda_function.lambda_for_stop.function_name}"
    principal = "events.amazonaws.com"
    source_arn = "${aws_cloudwatch_event_rule.console.arn}"
}

/*resource "aws_lambda_permission" "allow_cloudwatch_to_call_test_lambda_function_Start" {
    statement_id = "AllowExecutionFromCloudWatch"
    action = "lambda:InvokeFunction"
    function_name = "${aws_lambda_function.test_lambda_1.function_name}"
    principal = "events.amazonaws.com"
    source_arn = "${aws_cloudwatch_event_rule.console_1.arn}"
}*/