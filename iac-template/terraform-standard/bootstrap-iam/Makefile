init:
	terraform init --upgrade
apply: init
	terraform apply \
		-var="region=ap-northeast-1" \
		-var="account_name=dev" \
		-var="role_name=TerraformDeployRole-Dev" \
		-auto-approve
	terraform output
plan: init
	terraform plan -var="region=ap-northeast-1" -var="account_name=dev" -var="role_name=TerraformDeployRole-Dev"
output: init
	terraform output
destroy: init
	terraform destroy
