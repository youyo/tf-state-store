.DEFAULT_GOAL := help

## Deploy
deploy:
	aws --region us-east-1 serverlessrepo create-application-version \
		--application-id arn:aws:serverlessrepo:us-east-1:963262494726:applications/tf-state-store \
		--semantic-version `git describe --tags --abbrev=0` \
		--source-code-url 'https://github.com/youyo/tf-state-store' \
		--template-body file://template.yaml

## Show help
help:
	@make2help $(MAKEFILE_LIST)

.PHONY: help
.SILENT:
