#!/bin/bash
# Use this script as a quick execute shim for testing cfn stacks
STACKNAME="mcm-01-cloudformation-Lab5"
TESTFILE="file://IAMUserAndPolicy.yml"
PARAMFILE="file://IAMparams.json"
REGION='us-west-2'
CAPABILITIES='CAPABILITY_NAMED_IAM'

aws cloudformation create-stack --stack-name $STACKNAME --template-body $TESTFILE --parameters $PARAMFILE --region $REGION --capabilities $CAPABILITIES 

# aws cloudformation update-termination-protection --stack-name $STACKNAME --enable-termination-protection | --no-enable-termination-protection

# aws cloudformation describe-stack-events --stack-name $STACKNAME