import json


def handle(event, context):
    return {
        'source': event['data']['object']['source']
    }
