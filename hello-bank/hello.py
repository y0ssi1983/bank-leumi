import json

def lambda_handler(event, context):
  return {
    'statusCode': 200,
    'body': json.dumps('Hello Bank Leumi, I want to join you')
    }