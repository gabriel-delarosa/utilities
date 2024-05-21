#!/bin/bash

############ Prereqs: ####################################
## - AWS Cli
## - AWS Credentials loaded 
##########################################################

## how to get managed policies arn
## aws iam list-attached-role-policies --role-name < IAM Role Name > | jq .AttachedPolicies | grep ""PolicyArn"" | awk '{print $2}' | tr -s -d ',' '' | tr -s -d '"' ''

## how to get policy default version
## aws iam get-policy --policy-arn <ARN for the desired Policy> --query "[Policy.DefaultVersionId]" | tr -s -d "[]" "" | awk '{print $1}' | grep -v '^$' | tr -s -d '"' ''


## how to get managed policy json document
## aws iam get-policy-version --policy-arn <ARN for the desired Policy> --version-id < Policy Version >

## Get RoleName parameter
RoleName=$1

## for loop to get the Json document from Managed Policies (AWS Managed and Customer Managed)
##
if [ $# -eq 0 ]; then
	echo "Missing Role Name Argument"
	echo "Usage: "
	echo " ./get_managed_policies_json_docs.sh <RoleName>"
	exit 1
else
   for x in $(aws iam list-attached-role-policies --role-name $RoleName | jq .AttachedPolicies | grep "PolicyArn" | awk '{print $2}' | tr -s -d ',' '' | tr -s -d '"' ''); do
	for i in $(aws iam get-policy --policy-arn $x --query "[Policy.DefaultVersionId]" | tr -s -d "[]" "" | awk '{print $1}' | grep -v '^$' | tr -s -d '"' ''); do
		echo "Policy Document for: $x "; aws iam get-policy-version --policy-arn $x --version-id $i
		echo " "
	done
   done
fi

