clean-up:
	find / -type d -name ".terraform" -exec rm -rf {} \;

virginia:
	terraform workspace  new virginia || terraform workspace select virginia  && terraform init && terraform apply -var-file envs/virginia.tfvars  -auto-approve

ohio:
	terraform workspace  new ohio || terraform workspace select ohio  && terraform init && terraform apply -var-file envs/ohio.tfvars  -auto-approve

oregon:
	terraform workspace  new oregon || terraform workspace select oregon  && terraform init && terraform apply -var-file envs/oregon.tfvars  -auto-approve


california:
	terraform workspace  new california || terraform workspace select california  && terraform init && terraform apply -var-file envs/california.tfvars  -auto-approve


singapore:
	terraform workspace  new singapore || terraform workspace select singapore  && terraform init && terraform apply -var-file envs/singapore.tfvars  -auto-approve

london:
	terraform workspace  new london || terraform workspace select london  && terraform init && terraform apply -var-file envs/london.tfvars  -auto-approve


all:
	make virginia
	make ohio
	make california
	make oregon
	make singapore
	make london

destroy-virginia:
	terraform workspace  new virginia || terraform workspace select virginia  && terraform init && terraform destroy -var-file envs/virginia.tfvars  -auto-approve

destroy-ohio:
	terraform workspace  new ohio || terraform workspace select ohio  && terraform init && terraform destroy -var-file envs/ohio.tfvars  -auto-approve

destroy-oregon:
	terraform workspace  new oregon || terraform workspace select oregon  && terraform init && terraform destroy -var-file envs/oregon.tfvars  -auto-approve

destroy-california:
	terraform workspace  new california || terraform workspace select california  && terraform init && terraform destroy -var-file envs/california.tfvars  -auto-approve

destroy-singapore:
	terraform workspace  new singapore || terraform workspace select singapore  && terraform init && terraform destroy -var-file envs/singapore.tfvars  -auto-approve

destroy-london:
	terraform workspace  new london || terraform workspace select london  && terraform init && terraform destroy -var-file envs/london.tfvars  -auto-approve



destroy-all:
	make destroy-virginia
	make destroy-ohio
	make destroy-california
	make destroy-oregon
	make destroy-singapore
	make destroy-london
