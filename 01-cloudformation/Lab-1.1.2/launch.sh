#!/bin/bash
# Use this script as a quick execute shim for testing cfn stacks
STACKNAME="mcm-01-cloudformation"
TESTFILE="file://MinimalS3.yml"
PARAMFILE="file://s3params.yml"

aws cloudformation update-stack --stack-name $STACKNAME --template-body $TESTFILE --parameters $PARAMFILE