#!/bin/bash

aws cloudformation delete-stack \
    --stack-name apigateway

aws cloudformation create-stack \
    --stack-name apigateway \
    --template-body file://./template.json \
    --capabilities CAPABILITY_IAM
