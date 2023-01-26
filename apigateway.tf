#Create API-Gateway
resource "aws_apigatewayv2_api" "lambda" {
  name          = "serverless-lambda-apigw"
  protocol_type = "HTTP"
}

resource "aws_apigatewayv2_stage" "lambda" {
  api_id = aws_apigatewayv2_api.lambda.id
  name   = "serverless-lambda-stage"
}

resource "aws_apigatewayv2_integration" "hello_bank" {
  api_id                    = aws_apigatewayv2_api.lambda.id
  integration_uri           = aws_lambda_function.lambda_hello.invoke_arn
  integration_type          = "AWS_PROXY"
  integration_method        = "POST"
}

resource "aws_apigatewayv2_route" "hello_bank" {
  api_id = aws_apigatewayv2_api.lambda.id

  route_key = "GET /hello"
  target    = "integrations/${aws_apigatewayv2_integration.hello_bank.id}"
}

resource "aws_lambda_permission" "api_gw" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda_hello.function_name
  principal     = "apigateway.amazonaws.com"

  source_arn = "${aws_apigatewayv2_api.lambda.execution_arn}/*/*"
}