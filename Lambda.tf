data "archive_file" "lambda_zip" {
    type          = "zip"
    source_file   = "StopAllInstances.py"
    output_path   = "lambda_function.zip"
}

resource "aws_lambda_function" "lambda_for_stop" {
  filename         = "lambda_function.zip"
  function_name    = "StopAllInstances"
  role             = "${aws_iam_role.test_role.arn}"
  handler          = "StopAllInstances.lambda_handler"
  source_code_hash = "${data.archive_file.lambda_zip.output_base64sha256}"
  runtime          = "python3.8"
}