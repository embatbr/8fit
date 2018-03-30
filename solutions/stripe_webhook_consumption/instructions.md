# Instructions

Instructions to build the pipeline manually.

1. Create a Lambda function **stripe_webhooks_lambda** using Python 3.6 with role **stripe_webhooks_role** (create an AWS Lambda default role if it doesn't exist);
2. Add a file **event_extractor.py** with the content of the same:
    - Change the handler to **event_extractor.handle**.
3. Create an API **stripe_webhooks_api**;
4. Add a mock GET method for **/** (just for testing purposes):
    - Edit its **Integration Response** to return a non-empty body.
5. Add a POST method for the new resource **/events**, integrated to the Lambda function **stripe_webhooks_lambda**;
6. Deploy it in **dev** stage and Voilà!
