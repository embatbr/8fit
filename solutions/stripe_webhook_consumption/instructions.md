# Instructions

Instructions to build the pipeline manually.

1. Create a Lambda function **stripe_webhooks_lambda** using Python 3.6 with role **stripe_webhooks_role** (create a AWS Lambda default role if it doesn't exist);
2. Create an API **stripe_webhooks_api**;
3. Add a mock GET method for **/** (just for testing purposes):
    - Edit its **Integration Response** to return a non-empty body.
4. Deploy it in **dev** stage;
5. Back to the Lambda panel, add an API Gateway trigger:
    - Stage: dev
    - Security: open
6. Add a file **event_extractor.py** with the content of the same:
    - Change the handler to **event_extractor.handle**.
7. In the API Gateway panel, add a POST method for the new resource **/stripe_webhooks_lambda**, integrated to the Lambda function **stripe_webhooks_lambda**;
8. Deploy the API again, in the same stage;
9. Voilà!
