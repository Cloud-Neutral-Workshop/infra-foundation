# instance/ec2/Makefile

render:
python ../../render_provider_backend.py

init:
terraform init --upgrade

plan: init
terraform plan

import-existing: init
@echo "Reconciling existing AWS resources (key pair / security group)"
./import_existing.sh

apply: import-existing
terraform apply -auto-approve

output:
terraform output

destroy: init
terraform destroy -auto-approve
