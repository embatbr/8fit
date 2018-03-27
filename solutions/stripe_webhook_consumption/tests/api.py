import json
import os
import requests as r
import sys


args = sys.argv[1 : ]


token = args[0]
base_url = 'https://{}.execute-api.us-east-1.amazonaws.com/dev'.format(token)


print("Testing GET for '/'.")
resp = r.get(base_url)
print(resp.status_code)
print(resp.text)


my_path = os.path.dirname(os.path.abspath(__file__))
events = json.load(open('%s/events.json' % my_path))

print("\nTesting POST for '/stripe_webhooks_lambda'.")
url = '{}/stripe_webhooks_lambda'.format(base_url)
for event in events:
    resp = r.post(url, json=event)
    print(resp.status_code)
    print(json.dumps(resp.json(), indent=4))
