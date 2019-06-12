# tf-state-store

Create standard backend (S3+Dyanamodb) for terraform state files.  
https://www.terraform.io/docs/backends/types/s3.html

## Usage

Create a backend with three patterns.

- `aws cloudformation deploy`
- Deploy from serverless application repository.
- Include a AWS SAM template.

And execute `terraform init` .

### aws cloudformation deploy

```
$ aws cloudformation deploy \
	--stack-name tf-state-store \
	--template-file template.yaml \
	--capabilities CAPABILITY_NAMED_IAM

$ aws cloudformation describe-stacks \
	--stack-name tf-state-store | jq '.Stacks[0].Outputs'
[
  {
    "OutputKey": "TfStateLockTableName",
    "OutputValue": "tf-state-store-TfStateLockTable-1O5JKFU5AD4D7"
  },
  {
    "OutputKey": "TfStateBucketName",
    "OutputValue": "tf-state-store-tfstatebucket-wtj95cwl1jp7"
  }
]
```

### Deploy from serverless application repository

- Search `tf-state-store` .
- Deploy application.
- https://serverlessrepo.aws.amazon.com/applications/arn:aws:serverlessrepo:us-east-1:963262494726:applications~tf-state-store

### Include a AWS SAM template

```
AWSTemplateFormatVersion: '2010-09-09'
Transform: AWS::Serverless-2016-10-31
Resources:
  TerraformStateStore:
    Type: AWS::Serverless::Application
    Properties:
      Location:
        ApplicationId: arn:aws:serverlessrepo:ap-northeast-1:963262494726:applications/tf-state-store
        SemanticVersion: 0.0.2
      Parameters:
	  	TfStateBucketNoncurrentVersionExpirationInDays: 731
```

### And execute `terraform init`

Write `backend.tf`

```
terraform {
  backend "s3" {
    bucket         = "tf-state-store-tfstatebucket-wtj95cwl1jp7"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "tf-state-store-TfStateLockTable-1O5JKFU5AD4D7"
  }
}
```

And execute `terraform init`

```
$ terraform init
```

# License

MIT License (MIT)

This software is released under the MIT License, see LICENSE.txt.
