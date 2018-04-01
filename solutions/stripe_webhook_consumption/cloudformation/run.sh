#!/bin/bash


export PROJECT_ROOT_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd $PROJECT_ROOT_PATH


echo "Deleting..."
aws cloudformation delete-stack \
    --stack-name apigateway

sleep 5s

cd ../lambda
zip stripe_webhooks_lambda.zip event_extractor.py
aws s3 cp stripe_webhooks_lambda.zip s3://stripe-8fit/stripe_webhooks_lambda.zip
rm stripe_webhooks_lambda.zip

cd ../cloudformation
echo "Creating..."
aws cloudformation create-stack \
    --stack-name apigateway \
    --template-body file://./template.json \
    --capabilities CAPABILITY_IAM
