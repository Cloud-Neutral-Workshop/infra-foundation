bootstrap:
	terraform init --upgrade
	terraform apply \
		-var="table_name=svc-plus-iac-state-dynamodb-lock" \
		-var="region=ap-northeast-1" \
		-auto-approve
plan:
	terraform plan -var="table_name=svc-plus-iac-state-dynamodb-lock" -var="region=ap-northeast-1"
output:
	terraform output
destroy:
	terraform destroy

