output "function_name" {
  description = "Name of the Lambda function."

  value = aws_lambda_function.lambda_hello.function_name
}
output "lambda_bucket_name" {
  description = "Name of the S3 bucket used to store function code."

  value = aws_s3_bucket.lambda-leumi.id
}