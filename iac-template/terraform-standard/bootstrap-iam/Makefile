bootstrap:
	terraform init --upgrade
	terraform apply \
		-var="region=ap-northeast-1" \
		-var="account_name=dev" \
		-var="role_name=TerraformDeployRole-Dev" \
		-auto-approve
	terraform output

plan:
	terraform plan -var="region=ap-northeast-1" -var="account_name=dev" -var="role_name=TerraformDeployRole-Dev"
output:
	terraform output
destroy:
	terraform destroy
