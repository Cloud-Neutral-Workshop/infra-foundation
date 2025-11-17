bootstrap:
	terraform init --upgrade
	terraform apply -var="bucket_name=svc-plus-iac-state" -var=region=ap-northeast-1 -auto-approve
	terraform output

plan:
	terraform plan -var="bucket_name=svc-plus-iac-state" -var=region=ap-northeast-1

output:
	terraform output
destroy:
	terraform destroy
