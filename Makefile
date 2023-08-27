## Terraform

environment ?= dev

init:
	cd terraform && terraform init

upgrade:
	cd terraform && terraform init -upgrade
	
start:
	cd terraform && terraform $(action) -var-file="config/$(environment).tfvars" -compact-warnings

plan:
	cd terraform && terraform plan -var-file="config/$(environment).tfvars" -compact-warnings

refresh:
	cd terraform && terraform refresh -var-file="config/$(environment).tfvars" -compact-warnings

guided:
	cd terraform && make guided

output:
	cd terraform && terraform output

## Ansible

PRIVATE_KEY_PATH ?= ~/.ssh/id_rsa

playbook:
	ansible-playbook ansible/playbook/$(playbook) -i ansible/inventory

## Utils

OUTPUT_FILE = ansible/inventory/hosts
TEMP_FILE = temp_ip.txt

ssh:
	ssh -i $(PRIVATE_KEY_PATH) ubuntu@$(shell cd terraform && terraform output instance_public_dns)

update_host: temp_file populate clean_temp

temp_file:
	cd terraform && terraform output instance_public_dns > $(TEMP_FILE)

populate:
	echo "[aws_server]" > $(OUTPUT_FILE)
	cat ./terraform/$(TEMP_FILE) >> $(OUTPUT_FILE)
	echo "" >> $(OUTPUT_FILE)
	echo "[aws_server:vars]" >> $(OUTPUT_FILE)
	echo "ansible_ssh_user=ubuntu" >> $(OUTPUT_FILE)
	echo "ansible_ssh_private_key_file=$(PRIVATE_KEY_PATH)" >> $(OUTPUT_FILE)

clean_inventory:
	echo "[aws_server]" > $(OUTPUT_FILE)
	echo "" >> $(OUTPUT_FILE)
	echo "[aws_server:vars]" >> $(OUTPUT_FILE)
	echo "ansible_ssh_user=ubuntu" >> $(OUTPUT_FILE)
	echo "ansible_ssh_private_key_file=$(PRIVATE_KEY_PATH)" >> $(OUTPUT_FILE)

clean_temp:
	rm ./terraform/$(TEMP_FILE)