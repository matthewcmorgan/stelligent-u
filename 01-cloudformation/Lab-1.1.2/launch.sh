#!/bin/bash
# Use this script as a quick execute shim for testing cfn stacks
STACKNAME="mcm-01-cloudformation"
TESTFILE="file://S3viaParams.yml"
PARAMFILE="file://s3params.json"

aws cloudformation create-stack --stack-name $STACKNAME --template-body $TESTFILE --parameters $PARAMFILE