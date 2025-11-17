SHELL := /bin/bash

TF=terraform

init:
	$(TF) init --upgrade

plan:
	$(TF) plan

apply:
	$(TF) apply -auto-approve

destroy:
	$(TF) destroy -auto-approve

