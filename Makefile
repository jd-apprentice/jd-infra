## Terraform

init:
	cd terraform && terraform init

upgrade:
	cd terraform && terraform init -upgrade
	
start:
	cd terraform && terraform $(action) -var-file="modules/$(module)/$(environment).auto.tfvars"

guided:
	cd terraform && make guided

## Ansible

## TODO