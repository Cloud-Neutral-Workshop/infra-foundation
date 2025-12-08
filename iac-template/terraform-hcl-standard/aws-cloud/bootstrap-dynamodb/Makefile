table_name ?=
region ?=

TF_VARS := $(if $(table_name),-var="table_name=$(table_name)") $(if $(region),-var="region=$(region)")

init:
	terraform init --upgrade
	terraform init -migrate-state

apply: init
	terraform apply $(TF_VARS) -auto-approve

plan: init
	terraform plan $(TF_VARS)

output: init
	terraform output

destroy: init
	terraform destroy $(TF_VARS)
