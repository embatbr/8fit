#!/bin/bash


export PROJECT_ROOT_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd $PROJECT_ROOT_PATH


ACCOUNT_ID="$1"


echo "Deleting..."
aws cloudformation delete-stack \
    --stack-name apigateway

sleep 5s

python3 do_template.py $ACCOUNT_ID

cd ../lambda
zip receive_event.zip receive_event.py
aws s3 cp receive_event.zip s3://stripe-8fit/lambdas/receive_event.zip
rm receive_event.zip

cd ../cloudformation
echo "Creating..."
aws cloudformation create-stack \
    --stack-name apigateway \
    --template-body file://./final-template.json \
    --capabilities CAPABILITY_IAM CAPABILITY_NAMED_IAM

rm final-template.json
