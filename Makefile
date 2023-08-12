init:
	cd terraform && terraform init

upgrade:
	cd terraform && terraform init -upgrade

plan:
	cd terraform && terraform plan

apply_target:
	cd terraform && terraform apply -target=$(module) -var-file="secret.tfvars" -auto-approve

apply:
	cd terraform && terraform apply -var-file="secret.tfvars" -auto-approve 

destroy_target:
	cd terraform && terraform destroy -target=$(module) -var-file="secret.tfvars" -auto-approve

destroy:
	cd terraform && terraform destroy -var-file="secret.tfvars" -auto-approve