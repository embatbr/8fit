import json
import requests as r


token = 'odreor30pd' # change it for each new API
base_url = 'https://{}.execute-api.us-east-1.amazonaws.com/prod'.format(token)


print("Testing GET for '/'.")
resp = r.get(base_url)
print(resp.status_code)
print(json.dumps(resp.json(), indent=4))

print("\nTesting POST for '/stripe_webhooks_lambda'.")
resp = r.post('{}/stripe_webhooks_lambda'.format(base_url),
    json={
    "created": 1326853478,
    "livemode": False,
    "id": "evt_00000000000000",
    "type": "charge.succeeded",
    "object": "event",
    "data": {
        "object": {
            "id": "ch_00000000000000",
            "object": "charge",
            "created": 1380933505,
            "livemode": False,
            "paid": True,
            "amount": 1000,
            "currency": "usd",
            "refunded": False,
            "source": {
                "id": "cc_00000000000000",
                "object": "card",
                "last4": "4242",
                "type": "Visa",
                "brand": "Visa",
                "exp_month": 12,
                "exp_year": 2013,
                "fingerprint": "wXWJT135mEK107G8",
                "customer": "cus_00000000000000",
                "country": "US",
                "name": "Actual Nothing",
                "address_line1": None,
                "address_line2": None,
                "address_city": None,
                "address_state": None,
                "address_zip": None,
                "address_country": None,
                "cvc_check": None,
                "address_line1_check": None,
                "address_zip_check": None
            },
            "captured": True,
            "refunds": {},
            "balance_transaction": "txn_00000000000000",
            "failure_message": None,
            "failure_code": None,
            "amount_refunded": 0,
            "customer": "cus_00000000000000",
            "invoice": "in_00000000000000",
            "description": None,
            "dispute": None,
            "metadata": {}
            }
        }
    })
print(resp.status_code)
print(json.dumps(resp.json(), indent=4))
