#!/bin/bash

###############################################################################
# Author: Nayan Biswas
# Version: v0.0.1

# Script to automate the process of listing all the resources in an AWS account
#
# Below are the services that are supported by this script:
# 1. EC2
# 2. RDS
# 3. S3
# 4. CloudFront
# 5. VPC
# 6. IAM
# 7. Route53
# 8. CloudWatch
# 9. CloudFormation
# 10. Lambda
# 11. SNS
# 12. SQS
# 13. DynamoDB
# 14. VPC
# 15. EBS
#
# The script will prompt the user to enter the AWS region and the service for which the resources need to be listed.
#
# Usage: ./aws_resource_list.sh  <aws_region> <aws_service>
# Example: ./aws_resource_list.sh us-east-1 ec2
#############################################################################

# chacek require number of argument passd
if [ $# -ne 2 ]; then
    echo "Usage: ./aws_resource_list.sh  <aws_region> <aws_service>"
    echo "Example: ./aws_resource_list.sh us-east-1 ec2"
    exit 1
fi
# assign the argument to variable and covert to lower case 
aws_region=$1
aws_service=$(echo "$2" | tr '[:upper:]' '[:lower:]')

# check if the aws cli is installed 

if ! command -v aws &> /dev/null; then
    echo "AWS CLI is not installd please install it and try again"
    exit 1
fi

# check aws CLI is installed on your
if [ ! -d ~/.aws ]; then
    echo "AWS CLI is not configured. please configure it and try again "
    exit 1
fi


# exexute cli command base on the service name 

case  $aws_service in
    ec2)
        echo "Listening Ec2 Intance in $aws_region"
        aws ec2 describe-instances --region $aws_region
        ;;
    rds)
        echo "Listening RDS instance in $aws_region"
        aws rds describe-db-instances --region $aws_region
        ;;
    s3)
        echo "Listening s3 in $aws_region"
        aws s3api list-buckets --region $aws_region
        ;;
    cloudfront)
        echo "listening cloudfront in $aws_region"
        aws cloudformation describe-stacks --region $aws_region
        ;;
    vpc)
        echo "listening vpc in $aws_region"
        aws ec2 describe-vpcs --region $aws_region
        ;;
    iam)
        echo "listenint iam user in $aws_region"
        aws iam list-users --region $aws_region
        ;;
    route53)
        echo "Listing rote53 hosted zone in $aws_region"
        aws aws route53 list-hosted-zones --region $aws_region
        ;;
    cloudwatch)
        echo "Listion cloudwath alerm in $aws_region"
        aws cloudwatch describe-alarms --region $aws_region
        ;;
    cloudformation)
        echo "listing cloudformsation stack in $aws_region"
        aws cloudformation describe-stacks --region $aws_region
        ;;
    lambda)
        echo "listing all  lambda funtion in $aws_region"
        aws lambda list-functions --region $aws_region
        ;;
    sns)
        echo "listing sns topic in $aws_region"
        aws sns list-topics --region $aws_region
        ;;
    sqs)
        echo "Listing sqs Queues in $aws_region"
        aws sqs list-queues --region $aws_region
        ;;
    dynamodb)
        echo "listing dynamodb table in $aws_region"
        aws dynamodb list-tables --region $aws_region
        ;;
     ebs)
        echo "Listing EBS volumes in $aws_region"
        aws ec2 describe-volumes --region $aws_region
        ;;
    *)
        echo "Invalid service name pleas enter a valid service name"
        exit 1
        ;;
esac
    
    