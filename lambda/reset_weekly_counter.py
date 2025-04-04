import boto3

dynamodb = boto3.resource('dynamodb')
table = dynamodb.Table('visitor_counter')

def lambda_handler(event, context):
    table.put_item(
        Item={
            'id': 'weekly',
            'visits': 0
        }
    )
    return {
        'statusCode': 200,
        'body': 'Weekly counter reset to 0'
    }
