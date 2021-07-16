#!/bin/bash
# Use this script as a quick execute shim for testing cfn stacks
STACKNAME="mcm-01-cloudformation-Lab3"
TESTFILE="file://S3viaPsuedoParams.yml"
PARAMFILE="file://s3params.json"

aws cloudformation create-stack --stack-name $STACKNAME --template-body $TESTFILE --parameters $PARAMFILE