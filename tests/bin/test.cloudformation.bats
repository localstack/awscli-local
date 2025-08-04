#!/usr/bin/env bats

setup_file() {
  # Ensure the AWS CLI is configured to use LocalStack
  export AWS_ACCESS_KEY_ID=test
  export AWS_SECRET_ACCESS_KEY=test
  export AWS_DEFAULT_REGION=us-east-1

  # Create a bucket for the test
  awslocal s3 mb s3://cfn-package-lambdas
}

@test "cloudformation package, deploy, execute" {
  # Package the template
  run awslocal cloudformation package --template $BATS_TEST_DIRNAME/cfn_templates/lamba/template.yaml --output-template output/packaged_template.yaml --s3-bucket cfn-package-lambdas
  [ "$status" -eq 0 ]
  run awslocal cloudformation deploy --template-file output/packaged_template.yaml --stack-name test-stack
  [ "$status" -eq 0 ]
  URL=`awslocal cloudformation describe-stacks --stack-name test-stack --query "Stacks[0].Outputs[?OutputKey=='LambdaURL'].OutputValue" --output text`
  curl -s $URL | grep "Pong!"
  [ "$status" -eq 0 ]
}

teardown_file() {
  awslocal cloudformation delete-stack --stack-name test-stack
  awslocal s3 rb s3://cfn-package-lambdas --force
}