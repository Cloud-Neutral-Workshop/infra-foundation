bucket_name ?=
region ?=

TF_VARS := $(if $(bucket_name),-var="bucket_name=$(bucket_name)") $(if $(region),-var="region=$(region)")

init:
	terraform init --upgrade
	terraform init -migrate-state

apply: init
	terraform apply $(TF_VARS) -auto-approve
	terraform output

plan: init
	terraform plan $(TF_VARS)

output: init
	terraform output

destroy: init
	terraform destroy $(TF_VARS)
