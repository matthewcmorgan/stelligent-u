#!/bin/bash
# Use this script as a quick execute shim for testing cfn stacks
STACKNAME="mcm-01-cloudformation-Lab4"
TESTFILE="file://S3viaConditionalPsuedoParams.yml"
PARAMFILE="file://s3params.json"
REGION='us-east-2'

aws cloudformation create-stack --stack-name $STACKNAME --template-body $TESTFILE --parameters $PARAMFILE --region $REGION