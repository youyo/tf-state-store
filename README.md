# tf-state-store

Create standard backend (S3+Dyanamodb) for Terraform state files.  
https://www.terraform.io/docs/backends/types/s3.html

## Usage

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
  },
  {
    "OutputKey": "TfAdministratorAccesskey",
    "OutputValue": "AKIAU...LHV746J"
  },
  {
    "OutputKey": "TfAdministratorSecretAccesskey",
    "OutputValue": "caVk6L...CI1UAj0ie"
  }
]
```