.PHONY: all

all: init plan-with-no-colour

init:
	@echo "Removing cached terraform modules."
	@echo "Deploying into environment ${CURRENT_STAGE}"
	@rm -Rf .terraform/modules
	@echo "Initialiasing terraform for ** HELLO WORLD EXAMPLE ** environment."
	@terraform init -reconfigure -no-color ./terraform
	@echo "Validating terraform code."
	@terraform validate -no-color ./terraform

validate:
	@echo "Validating terraform code."
	@terraform validate -no-color ./terraform

plan: validate
	@echo "Running a terraform plan on ** APP SYNC EXAMPLE **."
	@terraform plan -parallelism=30 -refresh=true -out=./terraform/plan.out ./terraform

plan-with-no-colour: validate
	@echo "Running a terraform plan on ** APP SYNC EXAMPLE **."
	@terraform plan -parallelism=30 -no-color -refresh=true -out=./terraform/plan.out ./terraform

build: validate
	@echo "Building the infrastructure for ** APP SYNC EXAMPLE **."
	@terraform apply -no-color -auto-approve ./terraform

apply: validate build
	@echo "Validating the deployment for ** APP SYNC EXAMPLE **."
	@terraform plan -no-color -refresh=true -detailed-exitcode ./terraform
	@echo "Deployment is complete on ** APP SYNC EXAMPLE **."

deploy:
	@echo "Deploying serverless components for ** APP SYNC EXAMPLE **."
	@sls deploy -v
	@echo "Serverless deployment complete for ** APP SYNC EXAMPLE **."

clean:
	@echo "Removing serverless components for ** APP SYNC EXAMPLE **."
	@-sls remove -v
	@echo "Serverless removal complete for ** APP SYNC EXAMPLE **."
	@echo "Removing infrastructure components for ** APP SYNC EXAMPLE **."
	@-terraform destroy -auto-approve ./terraform
	@echo "Infrastructure removal complete for ** APP SYNC EXAMPLE **."
	@echo "Removing auto-generated files for ** APP SYNC EXAMPLE **."
	@-rm -Rf .terraform
	@-rm -Rf .serverless
	@-rm -Rf node_modules
	@-rm -Rf ./terraform/plan.out
	@-rm -Rf ./terraform.tfstate
	@-rm -Rf ./terraform.tfstate.backup
	@-rm -Rf ./package-lock.json
	@echo "Clean up complete for ** APP SYNC EXAMPLE **."