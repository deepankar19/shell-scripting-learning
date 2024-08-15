#!/bin/bash

#######################################################################

# Agenda  : Shell Script is used to list all resources in the AWS Account
# Author  : Devilvires/Devops Team
# Version : v0.0.1
#
# Following are the supported Aws services by the script
# 1. Ec2
# 2. S3
# 3. RDS
# 4. DynamoDB
# 5. EBS
# 6. ELS
# 7. CloudFront
# 8. CloudWatch
# 9. SNS
# 10. SQS
# 11. Route53
# 12. VPC
# 13. CloudFormation
# 14. IAM
# 15. EKS


# Execute : ./aws_resource_list_shell_script_01.sh <region> <services_name>
# Example : ./aws_resource_list_shell_script_01.sh us-east-1 EC2  
############################################################################

# check if the required number of argument is passed
if [ $# -ne 2 ]; then
    echo "Usage: ./aws_resource_list.sh  <aws_region> <aws_service>"
    echo "Example: ./aws_resource_list.sh us-east-1 ec2"
    exit 1
fi

# Assign the argument to variables and convert the service to lowercase
aws_region=$1
aws_service=$(echo "$2" | tr '[:upper:]' '[:lower:]')

# check if AWS CLI is installed or not
if ! command -v aws &> /dev/null; then
    echo "AWS CLI is not installed. Please install the AWS CLI and try again."
    exit 1
fi

# check if the AWS CLI is configured
if [ ! -d ~/.aws ]; then
    echo "AWS CLI is not configured. Please configure the AWS CLI and try again."
    exit 1
fi

# Execute the AWS CLI Command based on the service name
case $aws_service in
  ec2)
     echo "Listing EC2 Instance in $aws_region"
     aws ec2 describe-instances --region $aws_region
     ;;
  ec2-type)
     echo "Listing EC2 Instance Types in $aws_region, Please keep clam, this will take some time "
     aws ec2 describe-instance-types --region $aws_region
     ;;
  ec2-status)  
     echo "Listing EC2 Instance in $aws_region"
     aws ec2 describe-instance-status --region $aws_region
     ;;
  rds)
     echo "Listing RDS Instance in $aws_region"
     aws rds describe-db-instance --region $aws_region
     ;;
  s3)
   echo "Listing S3 Bucket in $aws_region"
     aws s3api list-bucket --region $aws_region
     ;;
  cloudfront)
    echo "Listing CloudFront Distribution in $aws_region"
     aws cloudfront list-distributions --region $aws_region
     ;;
  vpc)
     echo "Listing VPCs in $aws_region"
     aws ec2 describe-vpcs --region $aws_region
     ;;
   iam)
        echo "Listing IAM Users in $aws_region"
        aws iam list-users --region $aws_region
        ;;
    route5)
        echo "Listing Route53 Hosted Zones in $aws_region"
        aws route53 list-hosted-zones --region $aws_region
        ;;
    cloudwatch)
        echo "Listing CloudWatch Alarms in $aws_region"
        aws cloudwatch describe-alarms --region $aws_region
        ;;
    cloudformation)
        echo "Listing CloudFormation Stacks in $aws_region"
        aws cloudformation describe-stacks --region $aws_region
        ;;
    lambda)
        echo "Listing Lambda Functions in $aws_region"
        aws lambda list-functions --region $aws_region
        ;;
    sns)
        echo "Listing SNS Topics in $aws_region"
        aws sns list-topics --region $aws_region
        ;;
    sqs)
        echo "Listing SQS Queues in $aws_region"
        aws sqs list-queues --region $aws_region
        ;;
    dynamodb)
        echo "Listing DynamoDB Tables in $aws_region"
        aws dynamodb list-tables --region $aws_region
        ;;
    ebs)
        echo "Listing EBS Volumes in $aws_region"
        aws ec2 describe-volumes --region $aws_region
        ;;
    eks)
      echo "Listing EKS List Cluster in $aws_region"
        aws eks list-clusters --region $aws_region
        ;;
    *)
        echo "Invalid service. please enter a valid Service"
        exit 1
        ;;
    
    esac