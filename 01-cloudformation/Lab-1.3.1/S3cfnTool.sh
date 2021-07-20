#!/bin/bash

STACKNAME="mcm-01-cloudformation-Lab1-3-1"
TESTFILE="file://S3viaConditionalPsuedoParams.yml"
PARAMFILE="file://s3params.json"
REGION="$2" || 'us-east-1'
CAPABILITIES='CAPABILITY_NAMED_IAM'
# AWS_PAGER=""
# AWS_CLI_PAGER=""

help() {
	echo
	echo "S3cfnTool - a simple script that re-uses one CloudFormation template to deploy a single S3 bucket."
	echo "USAGE: S3cfnTool create 'us-west-2'"
	echo "VERBS: create describe update no-protect protect destroy"
	echo
}

create() {
	echo
	echo "Creating $STACKNAME in $REGION"
	aws cloudformation create-stack --stack-name $STACKNAME --template-body $TESTFILE --parameters $PARAMFILE --capabilities $CAPABILITIES --region "$REGION" | jq
	echo "Creation of $STACKNAME in $REGION submitted. Use describe for logs."
	echo
}

describe() {
	echo
	echo "Outputting events of $STACKNAME in $REGION."
	aws cloudformation describe-stack-events --stack-name $STACKNAME --region "$REGION" | jq
	echo "No more events. Run again."
	echo
}

update() {
	echo
	echo "Updating stack $STACKNAME in $REGION."
	aws cloudformation update-stack --stack-name $STACKNAME --template-body $TESTFILE --parameters $PARAMFILE --capabilities $CAPABILITIES --region "$REGION" | jq
	echo "Update submitted. Use describe for logs."
	echo
}

no-protect() {
	local CMD="aws cloudformation update-termination-problems --stack-name $STACKNAME --no-enable-termination-protection --region $REGION | jq"
	echo
	echo "Removing Deletion Protection on $STACKNAME. Are you sure? (Y/n)"
	select yn in "Yes" "No"; do
		case $yn in
			Yes ) $CMD; break;;
			No ) exit;;
		esac
	done
	echo "Deletion Proection Removal has been requested."
	echo
}

protect() {
	echo
	echo "Enabling deletion proection for stack: $STACKNAME"
	aws cloudformation update-termination-protection --stack-name $STACKNAME --enable-termination-protection --region "$REGION" | jq
	echo "Deletion Protection enabled."
	echo
}

destroy() {
	local CMD="aws cloudformation delete-stack --stack-name $STACKNAME --region $REGION | jq"
	echo
	echo "Destroying $STACKNAME. ARE YOU SURE? (Y/n)"
	select yn in "Yes" "No"; do
		case $yn in
			Yes ) $CMD; break;;
			No ) exit;;
		esac
	done
	echo "Delete stack request submitted. Use describe for logs."
	echo
}

main() {
	local cmd=$1
	if [[ $cmd == "create" ]]; then
		create
	elif [[ $cmd == "describe" ]]; then
		describe
	elif [[ $cmd == "update" ]]; then
		update
	elif [[ $cmd == "no-protect" ]]; then
		no-protect
	elif [[ $cmd == "protect" ]]; then
		protect
	elif [[ $cmd == "destroy" ]]; then
		destroy
	elif [[ -n "$cmd" ]]; then
		help
	fi
}

main "$@"