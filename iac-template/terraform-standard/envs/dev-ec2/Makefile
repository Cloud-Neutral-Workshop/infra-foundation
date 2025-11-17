# envs/dev-ec2/Makefile

init:
	terraform init --upgrade

plan: init
	terraform plan

apply: init
	terraform apply -auto-approve

output:
	terraform output

destroy: init
	terraform destroy -auto-approve

