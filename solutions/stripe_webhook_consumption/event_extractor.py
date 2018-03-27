import json


def handle(event, context):
    print()
    print(json.dumps(event, indent=4))
    print()

    return {
        'source': event['data']['object']['source']
    }
