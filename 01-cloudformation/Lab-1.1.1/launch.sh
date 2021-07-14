#!/bin/bash
# Use this script as a quick execute shim for testing cfn stacks
STACKNAME="mcm-01-cloudformation"
TESTFILE="file://MinimalS3.yml"

BUCKETNAMEVAR="$STACKNAME_$(date +"%m%d%Y%H%M")"

aws cloudformation update-stack --stack-name $STACKNAME --template-body $TESTFILE --parameters ParameterKey=BucketNameVar,ParameterValue=$BUCKETNAMEVAR