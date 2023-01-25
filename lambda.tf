data "archive_file" "lambda_hello_bank" {
  type = "zip"

  source_dir  = "${path.module}/hello-bank"
  output_path = "${path.module}/function.zip"
}

resource "aws_s3_object" "lambda_hello_bank" {
  bucket = aws_s3_bucket.lambda-leumi.id
  key    = "function.zip"
  source = data.archive_file.lambda_hello_bank.output_path
  etag = filemd5(data.archive_file.lambda_hello_bank.output_path)
}

resource "aws_iam_role" "iam_for_lambda" {
  name = "iam_for_lambda"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_lambda_function" "lambda_hello" {
  function_name = "Hello_Bank_Leumi"
  role          = aws_iam_role.iam_for_lambda.arn
  handler       = "hello.handler"
  s3_bucket     = aws_s3_bucket.lambda-leumi.id
  s3_key        = aws_s3_object.lambda_hello_bank.key
  source_code_hash = filebase64sha256(data.archive_file.lambda_hello_bank.output_path)

  runtime = "python3.9"

}