#!/usr/bin/env bats

setup_file() {
  # Ensure the AWS CLI is configured to use LocalStack
  export AWS_ACCESS_KEY_ID=test
  export AWS_SECRET_ACCESS_KEY=test
  export AWS_DEFAULT_REGION=us-east-1
}

@test "lambda list-functions" {
  run awslocal lambda list-functions
  [ "$status" -eq 0 ]
}

@test "s3api list-buckets" {
  run awslocal s3api list-buckets
  [ "$status" -eq 0 ]
}

@test "s3 ls" {
  run awslocal s3api list-buckets
  [ "$status" -eq 0 ]
}