#!/bin/bash

##################### Prereqs: ####################################################################################################################################
## - AWS Cli                                                                                                                                                     ##
## - AWS Credentials loaded              ##
###################################################################################################################################################################

## how to get inline policies
## aws iam list-role-policies --role-name < IAM Role Name > | jq .PolicyNames | tr -s -d ',' "" | grep -v -F "[" | grep -v -F "]" | tr -s -d '"' '' | awk '{print $1}' 

## how to get inline policy json document
## aws iam get-role-policy --role-name < IAM Role Name > --policy-name <Policy Name> 

## Get RoleName parameter
RoleName=$1

## for loop to get the Json document from Managed Policies (AWS Managed and Customer Managed)
##
if [ $# -eq 0 ]; then
	echo "Missing Role Name Argument"
	echo "Usage: "
	echo " ./get_inline_policies_docs.sh <RoleName>"
	exit 1
else
	for x in $(aws iam list-role-policies --role-name $RoleName | jq .PolicyNames | tr -s -d ',' "" | grep -v -F "[" | grep -v -F "]" | tr -s -d '"' '' | awk '{print $1}'); do
		echo " "; echo "Policy Document for: $x"; aws iam get-role-policy --role-name $RoleName --policy-name $x
       	done
fi

