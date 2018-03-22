### Background

For most of the changes happening [Stripe](https://stripe.com/docs/api) is providing [webhooks](https://stripe.com/docs/webhooks). In 8fit we need to store relevant transactional information (Charges in Stripe) to generate insights for various stakeholders:

- User acquisition wants to understand how much money they recovered after spending amount X on ads.
- Is a user still pro at a specific point in time?
- What’s the life time value of a user?
- How do renewal cohorts look like for specific plans?

### Your task

Your task is to build a python 3.6.X based ETL pipeline using Lambda, StepFunctions and API-Gateway so that an incoming webhook is triggering a lambda function executor which will execute a StepFunction. The layout of the StepFunction can have different designs and is up to you. But two things should happen within the StepFunction:

1. The posted JSON body (looking like [this](https://raw.githubusercontent.com/rebelidealist/stripe-ruby-mock/master/lib/stripe_mock/webhook_fixtures/charge.succeeded.json)) should be persisted in a Postgres DB hosted by RDS. The schema you use to do this is up to you. You might get some ideas from the use cases mentioned above.
2. From the posted JSON body you need to extract the source object and store this in CSV format as an object in S3

### Requirements

Please provide your solution in a Github repository. Add documentation and tests as you prefer. Please use CloudFormation and the [serverless](https://serverless.com/) framework for managing the infrastructure. Ideally we can run your code and infrastructure and connect against Stripe directly.