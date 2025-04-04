import json
import boto3

dynamodb = boto3.resource('dynamodb')
table = dynamodb.Table('visitor_counter')

def lambda_handler(event, context):
    try:
        method = event['requestContext']['http']['method']
        
        visitorCounters = {}

        if method == "GET":
            for counter_id in ['weekly', 'total']:
                response = table.get_item(Key={'id': counter_id})
                count = response.get('Item', {}).get('visits', 0)
                visitorCounters[counter_id] = int(count)

        else:  # POST
            for counter_id in ['weekly', 'total']:
                response = table.update_item(
                    Key={'id': counter_id},
                    UpdateExpression='ADD visits :inc',
                    ExpressionAttributeValues={':inc': 1},
                    ReturnValues='UPDATED_NEW'
                )
                visitorCounters[counter_id] = int(response['Attributes']['visits'])

        return {
            'statusCode': 200,
            'headers': {'Content-Type': 'application/json'},
            'body': json.dumps(visitorCounters)
        }

    except Exception as e:
        print("🔥 ERROR:", str(e))  # Will show in CloudWatch Logs
        return {
            'statusCode': 500,
            'body': json.dumps({'error': 'Internal Server Error', 'details': str(e)})
        }
