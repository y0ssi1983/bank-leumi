# Create API-Gateway
resource "aws_apigatewayv2_api" "lambda" {
  name          = "serverless-lambda-apigw"
  protocol_type = "HTTP"
}

# Use a single stage but can have more stages like "Test, Prod, Stagging"
resource "aws_apigatewayv2_stage" "lambda" {
  api_id = aws_apigatewayv2_api.lambda.id
  name   = "serverless-lambda-stage"
  auto_deploy = true
  access_log_settings {
    destination_arn = aws_cloudwatch_log_group.api_gw.arn

    format = jsonencode({
      requestId               = "$context.requestId"
      sourceIp                = "$context.identity.sourceIp"
      requestTime             = "$context.requestTime"
      protocol                = "$context.protocol"
      httpMethod              = "$context.httpMethod"
      resourcePath            = "$context.resourcePath"
      routeKey                = "$context.routeKey"
      status                  = "$context.status"
      responseLength          = "$context.responseLength"
      integrationErrorMessage = "$context.integrationErrorMessage"
      }
    )
  }
}

# Create Cloudwatch for logs for API-Gateway
resource "aws_cloudwatch_log_group" "api_gw" {
  name = "/aws/api_gw/${aws_apigatewayv2_api.lambda.name}"

  retention_in_days = 30
}

# Configure the API to use Lambda function
resource "aws_apigatewayv2_integration" "hello_bank" {
  api_id                    = aws_apigatewayv2_api.lambda.id
  integration_uri           = aws_lambda_function.lambda_hello.invoke_arn
  integration_type          = "AWS_PROXY"
  integration_method        = "POST"
}

# Maps the HTTP request to a target
resource "aws_apigatewayv2_route" "hello_bank" {
  api_id = aws_apigatewayv2_api.lambda.id

  route_key = "GET /hello"
  target    = "integrations/${aws_apigatewayv2_integration.hello_bank.id}"
}

# Give the API permission to invoke Lambda function
resource "aws_lambda_permission" "api_gw" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda_hello.function_name
  principal     = "apigateway.amazonaws.com"

  source_arn = "${aws_apigatewayv2_api.lambda.execution_arn}/*/*"
}